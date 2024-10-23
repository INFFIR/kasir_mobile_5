import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/components/bottom_nav_bar.dart';


class ActivityPegawaiPage extends StatelessWidget {
  const ActivityPegawaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Activity'),
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
                                'Pegawai n',
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
                                'Pegawai n',
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

                    const SizedBox(height: 400), // Jarak antar tombol
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
