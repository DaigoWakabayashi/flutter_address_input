import 'package:flutter/material.dart';
import 'package:flutter_address_input/pages/add_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('$runtimeType')),
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
