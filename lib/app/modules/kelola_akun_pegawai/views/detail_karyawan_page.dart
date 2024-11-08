import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/button_small.dart'; // Import ButtonSmall

class DetailKaryawanPage extends StatelessWidget {
  const DetailKaryawanPage({super.key});

  // Function to show the delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Penghapusan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Masukkan password untuk mengonfirmasi penghapusan akun.'),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back(); // Menutup dialog
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                String enteredPassword = _passwordController.text;
                
                // Replace this with your actual password verification logic
                bool isPasswordCorrect = enteredPassword == 'expectedPassword'; // Change 'expectedPassword' as needed

                if (isPasswordCorrect) {
                  Get.back(); // Menutup dialog konfirmasi
                  // Menampilkan pop-up berhasil setelah konfirmasi
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Berhasil'),
                        content: const Text('Akun berhasil dihapus.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed('/KelolaAkunPegawai'); // Navigasi ke halaman KelolaAkunPegawai
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Menampilkan pesan error jika password salah
                  Get.snackbar(
                    'Error',
                    'Password yang dimasukkan salah.',
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Hapus'),
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
        automaticallyImplyLeading: false, // Menghilangkan tombol back di pojok kiri atas
        title: const Text(
          'KELOLA AKUN PEGAWAI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey, // Warna header
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
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 75),
                  // Button 1: Aktivitas Akun
                  ButtonSmall(
                    icon: Icons.manage_accounts,
                    label: 'AKTIVITAS AKUN',
                    onPressed: () {
                      Get.toNamed('/ActivityPegawai'); // Mengganti dengan route untuk ActivityPegawai
                    },
                  ),
                  const SizedBox(height: 10),
                  // Button 2: Kirim Pesan
                  ButtonSmall(
                    icon: Icons.message,
                    label: 'KIRIM PESAN',
                    onPressed: () {
                      // TODO: Implement Kirim Pesan functionality
                    },
                  ),
                  const SizedBox(height: 10),
                  // Button 3: Hapus Akun
                  ButtonSmall(
                    icon: Icons.delete_outline,
                    label: 'HAPUS KARYAWAN',
                    onPressed: () {
                      _showDeleteConfirmationDialog(context);
                    },
                  ),
                  const SizedBox(height: 300),
                ],
              ),
            ),
          ),
          // Header Container with Username
          Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Align(
              child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF28374C),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'PEGAWAI n (Username)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
