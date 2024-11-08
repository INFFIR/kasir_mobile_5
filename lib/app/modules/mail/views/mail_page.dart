// file: lib/pages/mail_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/mail_button_widget.dart'; // Import widget kustom yang baru
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';

class MailPage extends StatelessWidget {
  const MailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('MAIL & UNDANGAN', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          // Gambar latar belakang
          Positioned.fill(
            child: Image.asset(
              'assets/background.png', // Ganti dengan path gambar Anda
              fit: BoxFit.cover, // Agar gambar menutupi seluruh halaman
            ),
          ),
          // Container untuk konten
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10,
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
                    // Seksi Undangan
                    const Text(
                      'Undangan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    MailButtonWidget(
                      title: 'Pemilik Toko x',
                      date: '29 - 9 2024 14:00 WIB',
                      description:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry...',
                      onPressed: () {
                        Get.toNamed('/TerimaUndangan'); // Aksi untuk tombol
                      },
                    ),
                    const SizedBox(height: 10),
                    MailButtonWidget(
                      title: 'Pemilik Toko y',
                      date: '29 - 9 2024 14:05 WIB',
                      description:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry...',
                      onPressed: () {
                        Get.toNamed('/TerimaUndangan'); // Aksi untuk tombol
                      },
                    ),
                    const SizedBox(height: 20),

                    // Seksi Mail
                    const Text(
                      'Mail',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    MailButtonWidget(
                      title: 'Pegawai A',
                      date: '29 - 9 2024 14:00 WIB',
                      description:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry...',
                      onPressed: () {
                        Get.toNamed('/MailOpen'); // Aksi untuk tombol
                      },
                    ),
                    const SizedBox(height: 10),
                    MailButtonWidget(
                      title: 'Pegawai B',
                      date: '29 - 9 2024 14:05 WIB',
                      description:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry...',
                      onPressed: () {
                        // Aksi untuk tombol
                      },
                    ),
                    const SizedBox(height: 10),
                    MailButtonWidget(
                      title: 'Pegawai C',
                      date: '29 - 9 2024 14:10 WIB',
                      description:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry...',
                      onPressed: () {
                        // Aksi untuk tombol
                      },
                    ),
                    const SizedBox(height: 10),
                    MailButtonWidget(
                      title: 'Pegawai D',
                      date: '29 - 9 2024 14:15 WIB',
                      description:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry...',
                      onPressed: () {
                        // Aksi untuk tombol
                      },
                    ),
                    const SizedBox(height: 10),
                    MailButtonWidget(
                      title: 'Pegawai E',
                      date: '29 - 9 2024 14:20 WIB',
                      description:
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry...',
                      onPressed: () {
                        // Aksi untuk tombol
                      },
                    ),
                    const SizedBox(height: 20),
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
