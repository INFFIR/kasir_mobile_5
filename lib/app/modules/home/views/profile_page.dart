import 'package:flutter/material.dart';
import 'home_page.dart'; // P

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                  const SizedBox(height: 50),
                  // Menampilkan foto profil
                  CircleAvatar(
                    radius: 50, // Ukuran lingkaran foto profil
                    backgroundImage: AssetImage('assets/profile_picture.png'), // Ganti dengan path gambar profil Anda
                  ),
                  const SizedBox(height: 20),
                  // Menampilkan nama pengguna
                  const Text(
                    'Nama Pengguna',
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xFF28374C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Menampilkan informasi pengguna
                  const Text(
                    'Informasi tambahan pengguna',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF28374C),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Button untuk mengganti username
                  _buildButton(
                    context,
                    icon: Icons.edit,
                    label: 'GANTI USERNAME',
                    onPressed: () {
                      // Tambahkan aksi yang diinginkan saat tombol ditekan
                    },
                  ),
                  const SizedBox(height: 20),
                  // Button untuk ganti password
                  _buildButton(
                    context,
                    icon: Icons.lock,
                    label: 'GANTI PASSWORD',
                    onPressed: () {
                      // Tambahkan aksi untuk ganti password
                    },
                  ),
                  const SizedBox(height: 20),
                  // Button untuk aktivitas anda
                  _buildButton(
                    context,
                    icon: Icons.history,
                    label: 'AKTIVITAS ANDA',
                    onPressed: () {
                      // Tambahkan aksi yang diinginkan saat tombol ditekan
                    },
                  ),
                  const SizedBox(height: 20),
                  // Button untuk log out
                  _buildButton(
                    context,
                    icon: Icons.logout,
                    label: 'LOG OUT',
                    onPressed: () {
                      // Tambahkan aksi untuk keluar dari akun
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey, // Warna Bottom Navbar
        selectedItemColor: Colors.white, // Warna item yang dipilih
        unselectedItemColor: Colors.white70, // Warna item yang tidak dipilih
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
          // Menangani navigasi berdasarkan indeks yang ditekan
          switch (index) {
            case 0:
              // Halaman Profile (saat ini aktif)
              break;
            case 1:
              // Navigasi ke Halaman Home
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()), // Ganti dengan nama kelas Home Anda
              );
              break;
            case 2:
              // Aksi untuk tombol Back
              Navigator.pop(context); // Kembali ke halaman sebelumnya
              break;
          }
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return SizedBox(
      height: 75,
      width: 350,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD9D9D9), // Warna button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Memposisikan ikon dan teks di tengah
          children: [
            // Menggunakan Expanded untuk mengatur rasio ukuran
            Expanded(
              flex: 3,
              child: Icon(icon, color: const Color(0xFF28374C), size: 30), // Ukuran ikon
            ),
            const SizedBox(width: 10), // Jarak antara ikon dan teks
            Expanded(
              flex: 7,
              child: Text(
                label,
                textAlign: TextAlign.center, // Memastikan teks di tengah
                style: const TextStyle(
                  color: Color(0xFF28374C),
                  fontSize: 20, // Ukuran teks
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








// lib/
// ├── app/
// │   ├── bindings/
// │   ├── controllers/
// │   │   └── login_controller.dart
// │   ├── models/
// │   │   └── user_model.dart
// │   ├── views/
// │   │   ├── home_page.dart
// │   │   ├── profile_page.dart
// │   │   ├── change_username_page.dart
// │   │   ├── change_password_page.dart
// │   │   └── activity_page.dart
// │   ├── routes/
// │   └── main.dart
// │
// └── assets/
//     ├── background.png
//     └── profile_picture.png

