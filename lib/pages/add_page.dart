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
    // FocusNode
    final zipcodeFocusNode = useFocusNode();
    final prefcodeFocusNode = useFocusNode();
    final address1FocusNode = useFocusNode();
    final address2FocusNode = useFocusNode();
    final address3FocusNode = useFocusNode();
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
    // Effect
    useEffect(() {
      zipcodeFocusNode.requestFocus();
      return null;
    }, const []);
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
              focusNode: zipcodeFocusNode,
              decoration: const InputDecoration(labelText: '郵便番号'),
              onEditingComplete: () => prefcodeFocusNode.requestFocus(),
            ),
            const Gap(8),
            TextFormField(
              controller: prefcodeController,
              focusNode: prefcodeFocusNode,
              decoration: const InputDecoration(labelText: '都道府県コード'),
              onEditingComplete: () => address1FocusNode.requestFocus(),
            ),
            const Gap(8),
            TextFormField(
              controller: address1Controller,
              focusNode: address1FocusNode,
              decoration: const InputDecoration(labelText: '都道府県'),
              onEditingComplete: () => address2FocusNode.requestFocus(),
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
              decoration: const InputDecoration(labelText: '町域'),
              onEditingComplete: () => FocusScope.of(context).unfocus(),
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
