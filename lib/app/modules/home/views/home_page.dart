import 'package:flutter/material.dart';
import 'profile_page.dart'; // Pastikan path ini sesuai dengan lokasi file ProfilePage


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              // Tambahkan aksi yang diinginkan saat ikon ditekan
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
                  SizedBox(
                    height: 150, // Mengatur tinggi button
                    width: 350,
                    child: ElevatedButton(
                      onPressed: () {},
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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
    // Tambahkan navigasi untuk Home dan Back jika diperlukan
  },
),

    );
  }
}
