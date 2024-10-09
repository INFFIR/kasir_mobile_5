import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AKTIVITAS ANDA'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: const Text(
          'Halaman untuk Aktivitas Anda',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
