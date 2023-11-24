import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_address_input/enums/prefecture.dart';
import 'package:flutter_address_input/models/address.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

/// TODO: Provider 引数に使っているため [Address] を immutable にする
final _addAddressProvider =
    Provider.autoDispose.family<Future<void>, Address>((ref, address) async {
  await FirebaseFirestore.instance
      .collection('addresses')
      .add(address.toJson());
});

class AddPage extends HookConsumerWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controller
    final zipcodeController = useTextEditingController();
    final address1State = useState<Prefecture?>(null);
    final address2Controller = useTextEditingController();
    final address3Controller = useTextEditingController();
    final address4Controller = useTextEditingController();
    // FocusNode
    final address2FocusNode = useFocusNode();
    final address3FocusNode = useFocusNode();
    final address4FocusNode = useFocusNode();
    // Validation
    final isValidZipcode = useListenableSelector(
      zipcodeController,
      () => zipcodeController.text.length == 7,
    );
    final isValidAddress1 = useListenableSelector(
      address1State,
      () => address1State.value != null,
    );
    final isValidAddress2 = useListenableSelector(
      address2Controller,
      () => address2Controller.text.isNotEmpty,
    );
    final isValidAddress3 = useListenableSelector(
      address3Controller,
      () => address3Controller.text.isNotEmpty,
    );
    final buttonEnabled =
        isValidZipcode && isValidAddress1 && isValidAddress2 && isValidAddress3;
    // Callback
    final add = useCallback(() async {
      final navigator = Navigator.of(context);
      ref.read(_addAddressProvider(Address(
        zipcode: zipcodeController.text,
        address1: address1State.value!.ja,
        address2: address2Controller.text,
        address3: address3Controller.text,
        address4: address4Controller.text,
      )));
      navigator.pop();
    }, [context]);

    return Scaffold(
      appBar: AppBar(), // バックボタン表示のため
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            TextFormField(
              autofocus: true,
              controller: zipcodeController,
              decoration: const InputDecoration(labelText: '郵便番号'),
              onChanged: (value) async {
                if (value.length != 7) return;
                final result = await zipCodeToAddress(zipcodeController.text);
                log(result.toString());
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(7),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const Gap(8),
            DropdownButtonFormField<Prefecture>(
              decoration: const InputDecoration(labelText: '都道府県'),
              items: Prefecture.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.ja)))
                  .toList(),
              onChanged: (value) {
                address1State.value = value;
                address2FocusNode.requestFocus();
              },
            ),
            const Gap(8),
            TextFormField(
              controller: address2Controller,
              focusNode: address2FocusNode,
              decoration: const InputDecoration(labelText: '市区町村'),
              onEditingComplete: () => address3FocusNode.requestFocus(),
            ),
            const Gap(8),
            TextFormField(
              controller: address3Controller,
              focusNode: address3FocusNode,
              decoration: const InputDecoration(labelText: '番地'),
              onEditingComplete: () => address4FocusNode.requestFocus(),
            ),
            const Gap(8),
            TextFormField(
              controller: address4Controller,
              focusNode: address4FocusNode,
              decoration: const InputDecoration(labelText: '建物名（任意）'),
              onEditingComplete: () => FocusScope.of(context).unfocus(),
            ),
            const Gap(16),
            Center(
              child: ElevatedButton(
                onPressed: buttonEnabled ? add : null,
                child: const Text('追加'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 郵便番号から住所を取得する
///
/// API: http://zipcloud.ibsnet.co.jp/doc/api
///
/// 利用規約: http://zipcloud.ibsnet.co.jp/rule/api
///
/// レスポンスサンプル
/// ```json
/// {
/// 	"message": null,
/// 	"results": [
/// 		{
/// 			"address1": "北海道",
/// 			"address2": "美唄市",
/// 			"address3": "上美唄町協和",
/// 			"kana1": "ﾎｯｶｲﾄﾞｳ",
/// 			"kana2": "ﾋﾞﾊﾞｲｼ",
/// 			"kana3": "ｶﾐﾋﾞﾊﾞｲﾁｮｳｷｮｳﾜ",
/// 			"prefcode": "1",
/// 			"zipcode": "0790177"
/// 		},
/// 		{
/// 			"address1": "北海道",
/// 			"address2": "美唄市",
/// 			"address3": "上美唄町南",
/// 			"kana1": "ﾎｯｶｲﾄﾞｳ",
/// 			"kana2": "ﾋﾞﾊﾞｲｼ",
/// 			"kana3": "ｶﾐﾋﾞﾊﾞｲﾁｮｳﾐﾅﾐ",
/// 			"prefcode": "1",
/// 			"zipcode": "0790177"
/// 		}
/// 	],
/// 	"status": 200
/// }
/// ```
Future<AddressResponse?> zipCodeToAddress(String zipCode) async {
  final response = await get(
    Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode'),
  );
  // 正常なステータスコードが返ってきているか
  if (response.statusCode != 200) {
    return null;
  }
  // ヒットした住所はあるか
  final result = jsonDecode(response.body);
  if (result['results'] == null) {
    return null;
  }
  // 結果が2つ以上のこともあるが、簡易的に最初のひとつを採用することとする
  final addressMap = (result['results'] as List).first;
  return (
    address1: addressMap['address1'] as String,
    address2: addressMap['address2'] as String,
    address3: addressMap['address3'] as String
  );
}

typedef AddressResponse = ({String address1, String address2, String address3});
