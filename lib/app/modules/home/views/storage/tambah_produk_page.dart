import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Untuk menggunakan File
import 'package:get/get.dart';

class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  _TambahProdukPageState createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  // TextEditingController untuk mengelola isi awal dari setiap TextField
  final TextEditingController _namaController = TextEditingController(text: '');
  final TextEditingController _deskripsiController = TextEditingController(text: '');
  final TextEditingController _hargaController = TextEditingController(text: '');
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _tambahJumlahController = TextEditingController(); // Kolom kedua untuk menambah jumlah

  // Variabel untuk menyimpan jumlah barang
  int jumlahBarang = 0;

  // Variabel untuk menyimpan gambar yang dipilih
  File? _imageFile;

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Simpan gambar yang dipilih
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Set nilai awal untuk jumlah barang
    _jumlahController.text = jumlahBarang.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'TAMBAH PRODUK',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: Colors.white,
            onPressed: () {
              // Aksi untuk menyimpan item
              Get.toNamed('/StoragePage'); // Mengganti dengan route untuk ProfilePage
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // Ganti dengan path gambar Anda
                fit: BoxFit.cover, // Mengatur agar gambar menutupi seluruh halaman
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8), // Transparansi
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight, // Menempatkan ikon pensil di kanan atas
                        children: [
                          Center( // Menggunakan Center untuk memusatkan gambar
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: _imageFile != null
                                      ? FileImage(_imageFile!) // Menampilkan gambar yang dipilih jika ada
                                      : const AssetImage('assets/produk/barang_1.jpeg') as ImageProvider, // Ganti dengan path gambar kamu
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10), // Radius sudut agar terlihat rapi
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: _pickImage, // Memanggil fungsi untuk memilih gambar
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Barang',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _deskripsiController,
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _hargaController,
                        decoration: const InputDecoration(
                          labelText: 'Harga',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Kolom untuk jumlah barang saat ini
                          Expanded(
                            child: TextField(
                              controller: _jumlahController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Jumlah Barang',
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Kolom kedua untuk menambah jumlah barang
                          Expanded(
                            child: TextField(
                              controller: _tambahJumlahController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Tambah Jumlah',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Menjumlahkan nilai dari kolom kedua ke kolom pertama
                          setState(() {
                            int tambahJumlah = int.tryParse(_tambahJumlahController.text) ?? 0;
                            jumlahBarang += tambahJumlah;
                            _jumlahController.text = jumlahBarang.toString();
                            _tambahJumlahController.clear(); // Kosongkan kolom kedua setelah dijumlahkan
                          });
                        },
                        child: const Text('Tambah ke Jumlah Barang'),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios_new),
            label: 'Back',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Get.toNamed('/profile'); // Mengganti dengan route untuk ProfilePage
          } else if (index == 1) {
            Get.offNamed('/home'); // Mengganti dengan route untuk HomePage
          } else if (index == 2) {
            Get.back(); // Menggunakan Get.back() untuk kembali ke halaman sebelumnya
          }
        },
      ),
    );
  }
}
