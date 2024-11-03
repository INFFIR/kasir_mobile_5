import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/widgets/button_large.dart';

class PilihModePage extends StatelessWidget {
  const PilihModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PILIH MODE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // Ganti dengan path gambar Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  ButtonLarge(
                    icon: Icons.store,
                    label: 'PEMILIK TOKO',
                    onPressed: () {
                      Get.toNamed('/PilihToko');
                    },
                  ),
                  const SizedBox(height: 20),
                  ButtonLarge(
                    icon: Icons.business_center,
                    label: 'PEGAWAI',
                    onPressed: () {
                      Get.toNamed('/PilihTempatKerja');
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
