import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back di pojok kiri atas
        title: const Text(
          'HALAMAN UTAMA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey, // Warna header
        actions: [
          IconButton(
            icon: const Icon(Icons.email), // Ikon email
            color: Colors.white,
            onPressed: () {

                        Get.toNamed('/Mail'); // Mengganti dengan route untuk ProfilePage
            },
          ),
        ],
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
          SingleChildScrollView( // Menambahkan SingleChildScrollView
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Button Transaksi
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 150, // Mengatur tinggi button
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {

                        Get.toNamed('/Transaksi'); // Mengganti dengan route untuk ProfilePage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9), // Warna button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 3, // 30% untuk ikon
                            child: Center(
                              child: Icon(
                                Icons.attach_money,
                                color: Color(0xFF28374C),
                                size: 40, // Mengatur ukuran ikon
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7, // 70% untuk teks
                            child: Center(
                              child: Text(
                                'TRANSAKSI',
                                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
                                style: TextStyle(
                                  color: Color(0xFF28374C), // Mengubah warna teks
                                  fontSize: 24, // Mengatur ukuran teks
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Button Stok Barang
                  SizedBox(
                    height: 150, // Mengatur tinggi button
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {

                        Get.toNamed('/Storage'); // Mengganti dengan route untuk ProfilePage
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
                            flex: 3, // 30% untuk ikon
                            child: Center(
                              child: Icon(
                                Icons.inventory,
                                color: Color(0xFF28374C),
                                size: 40, // Mengatur ukuran ikon
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7, // 70% untuk teks
                            child: Center(
                              child: Text(
                                'STOK BARANG',
                                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
                                style: TextStyle(
                                  color: Color(0xFF28374C),
                                  fontSize: 24, // Mengatur ukuran teks
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Button Riwayat
                  SizedBox(
                    height: 150, // Mengatur tinggi button
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {
  
                        Get.toNamed('/AllActivity'); // Mengganti dengan route untuk ProfilePage
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
                            flex: 3, // 30% untuk ikon
                            child: Center(
                              child: Icon(
                                Icons.history,
                                color: Color(0xFF28374C),
                                size: 40, // Mengatur ukuran ikon
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7, // 70% untuk teks
                            child: Center(
                              child: Text(
                                'RIWAYAT',
                                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
                                style: TextStyle(
                                  color: Color(0xFF28374C),
                                  fontSize: 24, // Mengatur ukuran teks
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Button Kelola Akun Pegawai
                  SizedBox(
                    height: 150, // Mengatur tinggi button
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {

                        Get.toNamed('/KelolaAkunPegawai'); // Mengganti dengan route untuk ProfilePage
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
                            flex: 3, // 30% untuk ikon
                            child: Center(
                              child: Icon(
                                Icons.person_add,
                                color: Color(0xFF28374C),
                                size: 40, // Mengatur ukuran ikon
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7, // 70% untuk teks
                            child: Center(
                              child: Text(
                                'KELOLA AKUN PEGAWAI',
                                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
                                style: TextStyle(
                                  color: Color(0xFF28374C),
                                  fontSize: 24, // Mengatur ukuran teks
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 200),
                ],
              ),
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

            Get.toNamed('/Profile'); // Mengganti dengan route untuk ProfilePage
          }
        },
      ),
    );
  }
}
