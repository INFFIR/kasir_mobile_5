import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/bottom_nav_bar.dart';
import 'package:kasir_mobile_5/app/modules/profile/widgets/button_profile.dart'; // Tambahkan impor ini

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
              Get.toNamed('/Mail'); // Mengganti dengan route untuk ProfilePage
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
                  const SizedBox(height: 50),
                  ButtonProfile(
                    icon: Icons.edit,
                    label: 'GANTI USERNAME',
                    onPressed: () {
                      Get.toNamed('/ChangeProfile'); // Mengganti dengan route untuk ProfilePage
                    },
                  ),
                  ButtonProfile(
                    icon: Icons.lock,
                    label: 'GANTI PASSWORD',
                    onPressed: () {
                      Get.toNamed('/ChangePassword'); // Mengganti dengan route untuk ProfilePage
                    },
                  ),
                  ButtonProfile(
                    icon: Icons.history,
                    label: 'AKTIVITAS ANDA',
                    onPressed: () {
                      Get.toNamed('/ActivityProfile'); // Mengganti dengan route untuk ProfilePage
                    },
                  ),
                  ButtonProfile(
                    icon: Icons.logout,
                    label: 'LOG OUT',
                    buttonColor: Colors.red, // Ganti warna tombol menjadi merah
                    onPressed: () {
                      Get.toNamed('/Login'); // Mengganti dengan route untuk ProfilePage
                    },
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
