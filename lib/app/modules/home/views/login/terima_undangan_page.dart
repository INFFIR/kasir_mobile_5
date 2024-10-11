import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/home/views/login/pilih_tempat_kerja_page.dart';

class TerimaUndanganPage extends StatelessWidget {
  const TerimaUndanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fungsi untuk menampilkan dialog pop-up
    void _showResponseDialog(BuildContext context, String message, Function onConfirm) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Konfirmasi"),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  onConfirm(); // Panggil fungsi setelah dialog ditutup
                },
              ),
            ],
          );
        },
      );
    }

    // Mendapatkan lebar dan tinggi layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10.0), // Jarak 10 piksel dari setiap sudut layar
                padding: const EdgeInsets.all(16.0), // Padding di dalam kotak
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // Latar belakang putih dengan sedikit transparansi
                  borderRadius: BorderRadius.circular(12), // Sudut membulat
                ),
                child: Column( // Menggunakan Column untuk menampung isi
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Memastikan konten memenuhi lebar
                  children: [
                    // Kotak untuk konten
                    Container(
                      margin: const EdgeInsets.all(10.0), // Jarak 10 piksel dari setiap sudut layar
                      padding: const EdgeInsets.all(16.0), // Padding di dalam kotak
                      width: screenWidth - 20, // Mengatur lebar kotak untuk mengisi seluruh layar - margin
                      height: screenHeight - 20, // Mengatur tinggi kotak sesuai dengan tinggi layar
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F2FA), // Warna kotak
                        borderRadius: BorderRadius.circular(12.0), // Sudut membulat
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
                        children: [
                          Row( // Header di dalam kotak
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pemilik Toko x',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                              Text(
                                '29 - 9 2024 14 : 00 WIB',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Mengubah warna teks menjadi hitam agar terlihat
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10), // Jarak antara header dan teks
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?", // Isi teks
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antar kotak
                    // Tombol 1 (Konfirmasi)
                    ElevatedButton(
                      onPressed: () {
                        _showResponseDialog(context, 'Undangan telah diterima!', () {
                          // Navigasi setelah pop-up ditutup
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PilihTempatKerjaPage(), // Sesuaikan halaman tujuan
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Ubah warna tombol menjadi hijau
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Terima Undangan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Ubah warna teks menjadi putih
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Jarak antara kedua tombol
                    // Tombol 2 (Tolak) yang ditumpuk di bawah
                    ElevatedButton(
                      onPressed: () {
                        _showResponseDialog(context, 'Undangan telah ditolak!', () {
                          // Navigasi setelah pop-up ditutup
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PilihTempatKerjaPage(), // Sesuaikan halaman tujuan
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Warna tombol tetap merah
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Tolak',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Ubah warna teks menjadi putih
                        ),
                      ),
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
