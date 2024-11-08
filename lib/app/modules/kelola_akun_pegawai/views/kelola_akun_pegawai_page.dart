import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/button_medium.dart';

class KelolaAkunPegawaiPage extends StatelessWidget {
  const KelolaAkunPegawaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back di pojok kiri atas
        title: const Text(
          'KELOLA AKUN PEGAWAI',
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
          const SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  // Button 1: Pegawai 1
                  ButtonMedium(
                    label: 'PEGAWAI 1 (Username)',
                    icon: Icons.manage_accounts,
                    routeName: '/DetailKaryawan',
                  ),
                  SizedBox(height: 10),
                  // Button 2: Pegawai 2
                  ButtonMedium(
                    label: 'PEGAWAI 2 (Username)',
                    icon: Icons.manage_accounts,
                    routeName: '/DetailKaryawan',
                  ),
                  SizedBox(height: 10),
                  // Button 3: Pegawai 3
                  ButtonMedium(
                    label: 'PEGAWAI 3 (Username)',
                    icon: Icons.manage_accounts,
                    routeName: '/DetailKaryawan',
                  ),
                  SizedBox(height: 300),
                ],
              ),
            ),
          ),
          // Floating Action Button (FAB) with '+' icon
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                // Action saat tombol '+' ditekan
                Get.toNamed('/TambahPegawai'); // Mengganti dengan route untuk ProfilePage
              },
              backgroundColor: const Color(0xFF28374C),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
