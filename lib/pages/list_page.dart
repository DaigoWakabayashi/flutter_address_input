import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_address_input/models/address.dart';
import 'package:flutter_address_input/pages/add_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _addressesStreamProvider = StreamProvider<List<Address>>((ref) {
  return FirebaseFirestore.instance
      .collection('addresses')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(
        (snap) => snap.docs.map((doc) => Address.fromJson(doc.data())).toList(),
      );
});

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(_addressesStreamProvider);
    return Scaffold(
      body: stream.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (addresses) => ListView.separated(
          itemCount: addresses.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, index) {
            final address = addresses[index];
            return ListTile(
              title: Text(address.address1),
              subtitle: Text(address.address2 + address.address3),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AddPage(),
            fullscreenDialog: true,
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
