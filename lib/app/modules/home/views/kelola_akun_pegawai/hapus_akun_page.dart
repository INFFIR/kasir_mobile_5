import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/home/views/kelola_akun_pegawai/kelola_akun_page.dart';
import '../home_page.dart';

class HapusAkunPage extends StatelessWidget {
  const HapusAkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back di pojok kiri atas
        title: const Text(
          'KELOLA AKUN PEGAWAI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey, // Warna header
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay for content
          Center(
            child: SizedBox(
              width: 350, // Tentukan lebar yang diinginkan
              child: SingleChildScrollView( // Menambahkan SingleChildScrollView untuk menghindari overflow
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), // Latar belakang putih dengan sedikit transparansi
                    borderRadius: BorderRadius.circular(12), // Sudut membulat
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Agar kolom hanya sebesar konten
                    children: [
                      // Icon Delete
                      Icon(
                        Icons.delete_outline,
                        size: 100,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(height: 20),

                      // Confirmation text
                      Text(
                        'MASUKKAN PASSWORD\nANDA UNTUK KONFIRMASI\nPENGHAPUSAN AKUN\n(USERNAME)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password input
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'MASUKKAN PASSWORD :',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Confirm Button
                      ElevatedButton(
                        onPressed: () {
                          // Menampilkan pop-up konfirmasi
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Konfirmasi'),
                                content: const Text('Apakah Anda yakin ingin menghapus akun ini?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Menutup dialog
                                    },
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Menutup dialog konfirmasi
                                      // Menampilkan pop-up berhasil setelah konfirmasi
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Berhasil'),
                                            content: const Text('Akun (USERNAME) berhasil dihapus.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (context) => const KelolaAkunPegawai()), // Ganti dengan nama kelas Home Anda
                                                  );
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey[800], // Text color
                          minimumSize: const Size(double.infinity, 50), // Full width button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'CONFIRM',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Back to Home Button
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()), // Ganti dengan nama kelas Home Anda
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50), // Full width button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: Text(
                          'KEMBALI KE BERANDA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
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
