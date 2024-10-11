import 'package:flutter/material.dart';
import '../homepage/home_page.dart'; // Pastikan Anda memiliki halaman HomePage
import '../login/login_page.dart';
import '../mail_page.dart';

class MemilihPembayaranPage extends StatelessWidget {
  const MemilihPembayaranPage({super.key});

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MailPage()), // Ganti dengan halaman ganti username
              );
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
                  const SizedBox(height: 40),
                  
                  _buildButton(
                    context,
                    icon: Icons.lock,
                    label: 'PEMBAYARAN MENGGUNAKAN CASH',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const ChangePasswordPage()), // Ganti dengan halaman ganti password
                      // );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildButton(
                    context,
                    icon: Icons.history,
                    label: 'PEMBAYARAN MENGGUNAKAN DEBIT',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const ActivityPage()), // Ganti dengan halaman aktivitas Anda
                      // );
                    },
                  ),
                  const SizedBox(height: 40),
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
    height: 250, // Menentukan tinggi tombol
    width: 350,  // Menentukan lebar tombol
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? const Color(0xFFD9D9D9), // Mengatur warna tombol
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // Mengatur radius sudut border tombol
        ),
        side: const BorderSide(
          color: Colors.blueGrey, // Mengatur warna border
          width: 2, // Mengatur ketebalan border
        ),
        minimumSize: const Size(200, 60), // Mengatur ukuran minimum tombol
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF28374C), size: 40),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF28374C),
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}

}
