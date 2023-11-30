import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_address_input/enums/prefecture.dart';
import 'package:flutter_address_input/models/address.dart';
import 'package:flutter_address_input/providers/loading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

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

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Gap(16),
            TextFormField(
              autofocus: true,
              controller: zipcodeController,
              decoration: const InputDecoration(labelText: '郵便番号'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(7),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (zipcode) async {
                if (zipcode.length != 7) return;
                ref.read(loadingProvider.notifier).show();
                final messenger = ScaffoldMessenger.of(context);
                final result = await _searchAddress(zipcode);
                // 結果があれば address3 まで入力
                if (result != null) {
                  address1State.value =
                      Prefecture.values.byCode(result.prefcode);
                  address2Controller.text = result.address2;
                  address3Controller.text = result.address3;
                  address3FocusNode.requestFocus();
                } else {
                  // 結果がなければ SnackBar 表示
                  messenger.showSnackBar(
                    const SnackBar(content: Text('住所が見つかりませんでした')),
                  );
                }
                ref.read(loadingProvider.notifier).hide();
              },
            ),
            const Gap(8),
            DropdownButtonFormField<Prefecture>(
              value: address1State.value,
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
                onPressed: buttonEnabled
                    ? () async {
                        final navigator = Navigator.of(context);
                        await FirebaseFirestore.instance
                            .collection('addresses')
                            .add(
                              Address(
                                zipcode: zipcodeController.text,
                                prefcode: address1State.value!.code.toString(),
                                address1: address1State.value!.ja,
                                address2: address2Controller.text,
                                address3: address3Controller.text,
                                address4: address4Controller.text,
                              ).toJson(),
                            );
                        navigator.pop();
                      }
                    : null,
                child: const Text('追加'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Address?> _searchAddress(String zipcode) async {
  final response = await http.get(
    Uri.parse('https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipcode'),
  );
  // 正常なレスポンスのみ処理
  if (response.statusCode != 200) {
    return null;
  }
  // パースして結果の配列を取得
  final body = jsonDecode(response.body) as Map<String, dynamic>;
  final results = body['results'] as List?;
  if (results == null || results.isEmpty) {
    return null;
  }
  // 複数の住所のうち、先頭の住所を使う
  final json = body['results'].first as Map<String, dynamic>;
  final address = Address.fromJson(json);
  return address;
}
