import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/bottom_nav_bar.dart';

class DetailKaryawanPage extends StatelessWidget {
  const DetailKaryawanPage({super.key});

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
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 75),
                  // Button 1: Tambah Akun
                SizedBox(
                    height: 100,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {

                        Get.toNamed('/ActivityPegawai'); // Mengganti dengan route untuk ProfilePage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Icon(
                                Icons.manage_accounts,
                                color: Color(0xFF28374C),
                                size: 40,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: Text(
                                'AKTIVITAS AKUN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF28374C),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Button 2: Kelola Akun
                  SizedBox(
                    height: 100,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Icon(
                                Icons.manage_accounts,
                                color: Color(0xFF28374C),
                                size: 40,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: Text(
                                'KIRIM PESAN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF28374C),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Button 3: Hapus Akun
                SizedBox(
                    height: 100,
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
   
                        Get.toNamed('/HapusAkun'); // Mengganti dengan route untuk ProfilePage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Icon(
                                Icons.manage_accounts,
                                color: Color(0xFF28374C),
                                size: 40,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: Text(
                                'HAPUS KARYAWAN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF28374C),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 300),
                ],
              ),
            ),
          ),
          // Floating Action Button (FAB) with '+' icon
          Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Align(
              child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF28374C),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'PEGAWAI n (Username)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
