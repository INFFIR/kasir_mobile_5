import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>?;

    final String? shopId = args?['shopId'] as String?;

    if (shopId == null || shopId.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'shopId tidak ditemukan. Pastikan Anda mengirim shopId saat navigasi.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        Get.back();
      });
      return;
    }

    Get.put<HomeController>(
      HomeController(shopId: shopId),
    );
  }
}
