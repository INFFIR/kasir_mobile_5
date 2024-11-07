import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

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
          // Navigasi ke ProfilePage
          Get.toNamed('/Profile');
        } else if (index == 1) {
          // Navigasi ke HomePage
          if (Get.currentRoute != '/Home') {
            // Cek apakah HomeController sudah diinisialisasi
            if (Get.isRegistered<HomeController>()) {
              final HomeController homeController = Get.find<HomeController>();
              final String shopId = homeController.shopId;

              // Navigasi ke Home dengan menyertakan shopId sebagai argumen
              Get.offAllNamed(
                '/Home',
                arguments: {'shopId': shopId},
              );
            } else {
              // Jika HomeController belum diinisialisasi, tampilkan pesan error
              Get.snackbar(
                'Error',
                'HomeController tidak ditemukan. Silakan coba lagi.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );
            }
          } else {
            // Jika sudah berada di Home, tampilkan pesan informasi (opsional)
            Get.snackbar(
              'Info',
              'Anda sudah berada di halaman Home.',
              snackPosition: SnackPosition.TOP,
            );
          }
        } else if (index == 2) {
          // Navigasi kembali ke halaman sebelumnya
          Get.back();
        }
      },
    );
  }
}
