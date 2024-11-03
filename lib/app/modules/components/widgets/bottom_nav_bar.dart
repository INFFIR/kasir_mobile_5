import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          Get.toNamed('/Profile'); // Ganti dengan route untuk ProfilePage
        } else if (index == 1) {
          Get.offAllNamed('/Home'); // Ganti dengan route untuk HomePage
        } else if (index == 2) {
          Get.back(); // Kembali ke halaman sebelumnya
        }
      },
    );
  }
}
