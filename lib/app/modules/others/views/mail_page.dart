import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/bottom_nav_bar.dart';

class MailPage extends StatelessWidget {
  const MailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('MAIL'),
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


              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9), // Latar belakang putih dengan sedikit transparansi
                borderRadius: BorderRadius.circular(12), // Sudut membulat
              ),
              child: SingleChildScrollView( // Membuat konten dapat digulir
                child: Column( // Menggunakan Column untuk menampung tombol
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Memastikan konten memenuhi lebar
                  children: [
                    // Tombol pertama dengan header
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF7F2FA), // Warna tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Mengatur border radius
                        ),
                      ),
                      onPressed: () {
                        // Aksi untuk tombol
  
                        Get.toNamed('/MailOpen'); // Mengganti dengan route untuk ProfilePage
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pegawai n',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                              Text(
                                '29 - 9 2024 14 : 00 WIB',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar tombol

                    // Tombol kedua
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF7F2FA), // Warna tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Mengatur border radius
                        ),
                      ),
                      onPressed: () {
                        // Aksi untuk tombol
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pegawai n',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                              Text(
                                '29 - 9 2024 14 : 05 WIB',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar tombol

                    // Tombol ketiga
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF7F2FA), // Warna tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Mengatur border radius
                        ),
                      ),
                      onPressed: () {
                        // Aksi untuk tombol
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pegawai n',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                              Text(
                                '29 - 9 2024 14 : 10 WIB',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar tombol

                    // Tombol keempat
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF7F2FA), // Warna tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Mengatur border radius
                        ),
                      ),
                      onPressed: () {
                        // Aksi untuk tombol
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pegawai n',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                              Text(
                                '29 - 9 2024 14 : 15 WIB',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar tombol

                    // Tombol kelima
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF7F2FA), // Warna tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Mengatur border radius
                        ),
                      ),
                      onPressed: () {
                        // Aksi untuk tombol
                      },
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam tombol
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pegawai n',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                              Text(
                                '29 - 9 2024 14 : 20 WIB',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Jarak antara header dan teks
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100)
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
