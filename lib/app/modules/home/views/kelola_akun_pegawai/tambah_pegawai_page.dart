import 'package:flutter/material.dart';
import '../home_page.dart'; // Pastikan Anda memiliki halaman HomePage
import '../profile/profile_page.dart';

class TambahPegawaiPage extends StatefulWidget {
  const TambahPegawaiPage({super.key});

  @override
  _TambahPegawaiPageState createState() => _TambahPegawaiPageState();
}

class _TambahPegawaiPageState extends State<TambahPegawaiPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  void _changeUsername() {
    // Logika untuk mengubah username
    // Anda dapat menambahkan logika untuk memproses dan menyimpan username di sini

    // Menampilkan pop-up dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Undangan Telah Dikirimkan!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UNDANG PEGAWAI'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username :',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(
                labelText: 'Pesan (Optional) :',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeUsername,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Undang Pegawai'),
            ),
          ],
        ),
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
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
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
}
