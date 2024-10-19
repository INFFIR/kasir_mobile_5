import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BuatTokoPage extends StatefulWidget {
  const BuatTokoPage({super.key});

  @override
  _BuatTokoPageState createState() => _BuatTokoPageState();
}

class _BuatTokoPageState extends State<BuatTokoPage> {
  final TextEditingController _usernameController = TextEditingController();

  void _changeProfile() {
    // Logika untuk mengubah username
    // Tambahkan logika untuk memproses dan menyimpan username di sini

    // Menampilkan pop-up dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('TOKO BERHASIl DIBUAT!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog

                Get.offNamed('/PilihToko'); // Mengganti dengan route untuk HomePage
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
        title: const Text(
          'BUAT TOKO',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey, // Warna header
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
                      const Text(
                    "BUAT TOKO",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                                    const SizedBox(height: 60),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'NAMA TOKO ANDA:',
                        filled: true,
                        fillColor: Colors.grey.shade200.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: false, // Username tidak perlu disembunyikan
                    ),
  

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _changeProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('BUAT TOKO'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
