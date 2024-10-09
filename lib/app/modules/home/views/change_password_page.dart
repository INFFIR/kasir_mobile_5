import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GANTI PASSWORD'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: const Text(
          'Halaman untuk Ganti Password',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
