import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/bottom_nav_bar.dart';
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _changePassword() {
    // Logika untuk mengubah password
    // Tambahkan logika untuk memproses dan menyimpan password di sini

    // Menampilkan pop-up dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Password berhasil diubah!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UBAH PASSWORD'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png', // Ganti dengan path gambar Anda
              fit: BoxFit.cover, // Agar gambar menutupi seluruh halaman
            ),
          ),
          // Form and elements with white background
          Center(
            child: SizedBox(
              width: 350, // Tentukan lebar yang diinginkan
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // Latar belakang putih dengan sedikit transparansi
                  borderRadius: BorderRadius.circular(12), // Sudut membulat
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Agar kolom hanya sebesar konten
                  children: [
                    TextField(
                      controller: _oldPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Password Lama :',
                        filled: true,
                        fillColor: Colors.grey.shade200.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _newPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Password Baru :',
                        filled: true,
                        fillColor: Colors.grey.shade200.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Ulangi Password Baru :',
                        filled: true,
                        fillColor: Colors.grey.shade200.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: _changePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Ubah Password'),
                    ),
                  ],
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
