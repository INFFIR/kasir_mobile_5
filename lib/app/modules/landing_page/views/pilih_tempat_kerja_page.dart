// pages/pilih_tempat_kerja_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/pilih_tempat_kerja_controller.dart';
import '../widgets/pilih_tempat_kerja_card.dart'; // Pastikan path ini benar

class PilihTempatKerjaPage extends StatelessWidget {
  const PilihTempatKerjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan GetBuilder atau Obx untuk reaktif
    final PilihTempatKerjaController controller = Get.find<PilihTempatKerjaController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PEMILIHAN TEMPAT KERJA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey, // Warna header
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // Ganti dengan path gambar Anda
                fit: BoxFit.cover, // Mengatur agar gambar menutupi seluruh halaman
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              if (controller.tempatKerjaList.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada tempat kerja tersedia.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.tempatKerjaList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot tempatKerja = controller.tempatKerjaList[index];
                  return PilihTempatKerjaCard(tempatKerja: tempatKerja);
                },
              );
            }),
          ),
          // Floating Action Button (FAB) dengan ikon '+'
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Aksi saat tombol '+' ditekan
                Get.toNamed('/Mail'); // Ganti dengan route yang sesuai
              },
              backgroundColor: const Color(0xFF28374C),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
