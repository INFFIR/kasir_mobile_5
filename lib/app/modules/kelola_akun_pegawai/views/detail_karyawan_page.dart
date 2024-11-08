import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/button_small.dart';

class DetailKaryawanPage extends StatelessWidget {
  const DetailKaryawanPage({super.key});

  void _showDeleteConfirmationDialog(BuildContext context, String employeeId, String shopId) {
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
              onPressed: () async {
                String enteredPassword = _passwordController.text;

                // Verifikasi password pemilik toko
                try {
                  String email = FirebaseAuth.instance.currentUser!.email!;
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: enteredPassword,
                  );

                  // Hapus pegawai dari toko
                  await FirebaseFirestore.instance
                      .collection('employee_shops')
                      .doc(employeeId + '_' + shopId)
                      .delete();

                  Get.back(); // Menutup dialog konfirmasi
                  // Menampilkan pop-up berhasil setelah konfirmasi
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Berhasil'),
                        content: const Text('Akun pegawai berhasil dihapus.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed('/KelolaAkunPegawai', arguments: {'shopId': shopId});
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
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
    final String employeeId = Get.arguments['employeeId'];
    final String shopId = Get.arguments['shopId'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'KELOLA AKUN PEGAWAI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(employeeId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
              }
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('Data pegawai tidak ditemukan.'));
              }
              var employeeData = snapshot.data!;
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 75),
                      ButtonSmall(
                        icon: Icons.manage_accounts,
                        label: 'AKTIVITAS AKUN',
                        onPressed: () {
                          Get.toNamed('/ActivityPegawai', arguments: {'employeeId': employeeId});
                        },
                      ),
                      const SizedBox(height: 10),
                      ButtonSmall(
                        icon: Icons.message,
                        label: 'KIRIM PESAN',
                        onPressed: () {
                          // TODO: Implement Kirim Pesan functionality
                        },
                      ),
                      const SizedBox(height: 10),
                      ButtonSmall(
                        icon: Icons.delete_outline,
                        label: 'HAPUS KARYAWAN',
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, employeeId, shopId);
                        },
                      ),
                      const SizedBox(height: 300),
                    ],
                  ),
                ),
              );
            },
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
                child: Center(
                  child: Text(
                    'PEGAWAI (${Get.arguments['employeeId']})',
                    style: const TextStyle(
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
