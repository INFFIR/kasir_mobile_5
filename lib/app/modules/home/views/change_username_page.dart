import 'package:flutter/material.dart';

class ChangeUsernamePage extends StatelessWidget {
  const ChangeUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GANTI USERNAME'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: const Text(
          'Halaman untuk mengganti username',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
