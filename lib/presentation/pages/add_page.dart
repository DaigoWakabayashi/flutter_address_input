import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_address_input/domain/address.dart';
import 'package:flutter_address_input/presentation/providers/address.dart';
import 'package:flutter_address_input/presentation/providers/loading.dart';
import 'package:flutter_address_input/util/prefecture.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    // zipcode の FocusNode → autoFocus:true
    // address1 の FocusNode → AutoFill が成功した場合は address3 へ・失敗した場合は zipCode でのフォーカスを留めるため不要
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            TextFormField(
              autofocus: true,
              controller: zipcodeController,
              decoration: const InputDecoration(labelText: '郵便番号'),
              keyboardType: TextInputType.number,
              // 他の TextField の TapRegion は侵さないので、ひとつ指定するだけでも OK https://api.flutter.dev/flutter/widgets/TextFieldTapRegion-class.html
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              inputFormatters: [
                LengthLimitingTextInputFormatter(7),
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) async {
                if (value.length != 7) return;
                ref.read(loadingProvider.notifier).show();
                final res = await ref
                    .read(searchAddressFromZipcodeProvider(value).future);
                if (res != null) {
                  address1State.value = res.address1;
                  address2Controller.text = res.address2;
                  address3Controller.text = res.address3;
                  address3FocusNode.requestFocus();
                }
                ref.read(loadingProvider.notifier).hide();
              },
            ),
            const Gap(8),
            DropdownButtonFormField<Prefecture>(
              value: address1State.value,
              decoration: const InputDecoration(labelText: '都道府県'),
              menuMaxHeight: MediaQuery.sizeOf(context).height / 2,
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
