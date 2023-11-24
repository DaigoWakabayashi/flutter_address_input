import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';

class AddPage extends HookWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller
    final zipcodeController = useTextEditingController();
    final prefcodeController = useTextEditingController();
    final address1Controller = useTextEditingController();
    final address2Controller = useTextEditingController();
    final address3Controller = useTextEditingController();
    // Validation
    final isValidZipcode = useListenableSelector(
      zipcodeController,
      () => zipcodeController.text.isNotEmpty,
    );
    final isValidPrefcode = useListenableSelector(
      prefcodeController,
      () => prefcodeController.text.isNotEmpty,
    );
    final isValidAddress1 = useListenableSelector(
      address1Controller,
      () => address1Controller.text.isNotEmpty,
    );
    final isValidAddress2 = useListenableSelector(
      address2Controller,
      () => address2Controller.text.isNotEmpty,
    );
    final isValidAddress3 = useListenableSelector(
      address3Controller,
      () => address3Controller.text.isNotEmpty,
    );
    final buttonEnabled = isValidZipcode &&
        isValidPrefcode &&
        isValidAddress1 &&
        isValidAddress2 &&
        isValidAddress3;
    // Callback
    final add = useCallback(() async {
      final navigator = Navigator.of(context);
      await FirebaseFirestore.instance.collection('addresses').add({
        'zipcode': zipcodeController.text,
        'prefcode': prefcodeController.text,
        'address1': address1Controller.text,
        'address2': address2Controller.text,
        'address3': address3Controller.text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      navigator.pop();
    }, [context]);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Gap(16),
            TextFormField(
              controller: zipcodeController,
              decoration: const InputDecoration(
                labelText: '郵便番号',
              ),
            ),
            const Gap(8),
            TextFormField(
              controller: prefcodeController,
              decoration: const InputDecoration(
                labelText: '都道府県コード',
              ),
            ),
            const Gap(8),
            TextFormField(
              controller: address1Controller,
              decoration: const InputDecoration(
                labelText: '都道府県',
              ),
            ),
            const Gap(8),
            TextFormField(
              controller: address2Controller,
              decoration: const InputDecoration(
                labelText: '市区町村',
              ),
            ),
            const Gap(8),
            TextFormField(
              controller: address3Controller,
              decoration: const InputDecoration(
                labelText: '町域',
              ),
            ),
            const Gap(8),
            ElevatedButton(
              onPressed: buttonEnabled ? add : null,
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}
