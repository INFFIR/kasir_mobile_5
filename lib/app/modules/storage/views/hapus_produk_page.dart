import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/bottom_nav_bar.dart';
class HapusProdukPage extends StatelessWidget {
  const HapusProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back di pojok kiri atas
        title: const Text(
          'HAPUS PRODUK',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey, // Warna header
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay for content
          Center(
            child: SizedBox(
              width: 350, // Tentukan lebar yang diinginkan
              child: SingleChildScrollView( // Menambahkan SingleChildScrollView untuk menghindari overflow
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8), // Latar belakang putih dengan sedikit transparansi
                    borderRadius: BorderRadius.circular(12), // Sudut membulat
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Agar kolom hanya sebesar konten
                    children: [
                      // Icon Delete
                      Icon(
                        Icons.delete_outline,
                        size: 100,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(height: 20),

                      // Confirmation text
                      Text(
                        'MASUKKAN PASSWORD\nANDA UNTUK KONFIRMASI\nPENGHAPUSAN PRODUK\n(USERNAME)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password input
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'MASUKKAN PASSWORD :',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Confirm Button
                      ElevatedButton(
                        onPressed: () {
                          // Menampilkan pop-up konfirmasi
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Konfirmasi'),
                                content: const Text('Apakah Anda yakin ingin menghapus akun ini?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Get.back(); // Menggunakan Get.back() untuk kembali ke halaman sebelumnya
                                    },
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                       Get.back(); // Menggunakan Get.back() untuk kembali ke halaman sebelumnya
                                      // Menampilkan pop-up berhasil setelah konfirmasi
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Berhasil'),
                                            content: const Text('Akun (USERNAME) berhasil dihapus.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Get.offNamed('/HomKelolaAkunPegawai'); // Mengganti dengan route untuk ProfilePage
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey[800], // Text color
                          minimumSize: const Size(double.infinity, 50), // Full width button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'CONFIRM',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Back to Home Button
                      OutlinedButton(
                        onPressed: () {
                          Get.offNamed('/Home'); // Mengganti dengan route untuk ProfilePage
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50), // Full width button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: Text(
                          'KEMBALI KE BERANDA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
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
