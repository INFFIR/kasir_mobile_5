import 'package:flutter/material.dart';
import 'home_page.dart'; // Pastikan Anda memiliki halaman HomePage
import 'change_username_page.dart'; // Ganti dengan halaman ganti username
import 'change_password_page.dart'; // Ganti dengan halaman ganti password
import 'activity_page.dart'; // Ganti dengan halaman aktivitas Anda
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'HALAMAN UTAMA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.email),
            color: Colors.white,
            onPressed: () {
              // Tambahkan aksi yang diinginkan saat ikon ditekan
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
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_picture.jpeg'), // Ganti dengan path gambar profil Anda
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nama Pengguna',
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xFF28374C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Deskripsi / Bio',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF28374C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 50),
                  _buildButton(
                    context,
                    icon: Icons.edit,
                    label: 'GANTI USERNAME',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChangeUsernamePage()), // Ganti dengan halaman ganti username
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildButton(
                    context,
                    icon: Icons.lock,
                    label: 'GANTI PASSWORD',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChangePasswordPage()), // Ganti dengan halaman ganti password
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildButton(
                    context,
                    icon: Icons.history,
                    label: 'AKTIVITAS ANDA',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ActivityPage()), // Ganti dengan halaman aktivitas Anda
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildButton(
                    context,
                    icon: Icons.logout,
                    label: 'LOG OUT',
                    buttonColor: Colors.red, // Ganti warna tombol menjadi merah
                    onPressed: () {
                      // Tambahkan aksi untuk keluar dari akun
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
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
          switch (index) {
            case 0:
              // Halaman Profile (saat ini aktif)
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()), // Ganti dengan nama kelas Home Anda
              );
              break;
            case 2:
              Navigator.pop(context); // Kembali ke halaman sebelumnya
              break;
          }
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed, Color? buttonColor}) {
    return SizedBox(
      height: 75,
      width: 350,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? const Color(0xFFD9D9D9), // Gunakan buttonColor jika ada
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Icon(icon, color: const Color(0xFF28374C), size: 30),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 7,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF28374C),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
