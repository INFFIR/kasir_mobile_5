import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuatTokoPage extends StatefulWidget {
  const BuatTokoPage({super.key}); // Menggunakan 'const'

  @override
  _BuatTokoPageState createState() => _BuatTokoPageState();
}

class _BuatTokoPageState extends State<BuatTokoPage> {
  final TextEditingController _namaTokoController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _buatToko() async {
    String namaToko = _namaTokoController.text.trim();
    if (namaToko.isEmpty) {
      Get.snackbar(
        'Error',
        'Nama toko tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    String userId = _auth.currentUser!.uid;

    try {
      await _firestore.collection('shops').add({
        'name': namaToko,
        'ownerId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: const Text('TOKO BERHASIL DIBUAT!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                  Get.offNamed('/PilihToko');
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      Get.snackbar(
        'Error',
        'Gagal membuat toko: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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
                      controller: _namaTokoController,
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
                      onPressed: _buatToko,
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
