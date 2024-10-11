import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/home/views/homepage/home_page.dart';
import 'profile/profile_page.dart';


class AllActivityPage extends StatelessWidget {
  const AllActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ALL ACTIVITY'),
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
          // Container untuk konten
          Positioned(
            top: 10, // Jarak dari atas
            left: 10, // Jarak dari kiri
            right: 10, // Jarak dari kanan
            bottom: 10, // Jarak dari bawah
            child: Container(
              width: double.infinity, // Mengisi lebar penuh dari posisi
              height: double.infinity, // Mengisi tinggi penuh dari posisi
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), // Latar belakang putih dengan sedikit transparansi
                borderRadius: BorderRadius.circular(12), // Sudut membulat
              ),
              child: SingleChildScrollView( // Membuat konten dapat digulir
                child: Column( // Menggunakan Column untuk menampung tombol
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Memastikan konten memenuhi lebar
                  children: [
                    // Tombol pertama dengan header
                    ElevatedButton(
                      onPressed: () {
                        // Aksi untuk tombol pertama
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '29 - 9 2024 14 : 00 WIB',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text('Telah melakukan penghapusan produk'), // Teks aktivitas
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar tombol

                    // Tombol kedua dengan header
                    ElevatedButton(
                      onPressed: () {
                        // Aksi untuk tombol kedua
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '29 - 9 2024 14 : 05 WIB',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text('Telah melakukan penambahan produk'), // Teks aktivitas
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar tombol

                    // Tombol ketiga dengan header
                    ElevatedButton(
                      onPressed: () {
                        // Aksi untuk tombol ketiga
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '29 - 9 2024 14 : 10 WIB',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text('Telah melakukan pembaruan produk'), // Teks aktivitas
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar tombol

                    // Tombol keempat dengan header
                    ElevatedButton(
                      onPressed: () {
                        // Aksi untuk tombol keempat
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '29 - 9 2024 14 : 15 WIB',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text('Telah melakukan penghapusan pengguna'), // Teks aktivitas
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar tombol

                    // Tombol kelima dengan header
                    ElevatedButton(
                      onPressed: () {
                        // Aksi untuk tombol kelima
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '29 - 9 2024 14 : 20 WIB',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text('Telah melakukan pemulihan produk'), // Teks aktivitas
                        ],
                      ),
                    ),
                    const SizedBox(height: 400), // Jarak antar tombol
                  ],
                ),
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
            // Navigasi ke halaman Profile
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()), // Ganti dengan nama kelas Home Anda
            );
          } else if (index == 2) {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          }
        },
      ),
    );
  }
}
