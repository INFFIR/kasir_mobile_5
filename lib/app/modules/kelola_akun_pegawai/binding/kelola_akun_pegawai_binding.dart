import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kelola_akun_pegawai_controller.dart';

class KelolaAkunPegawaiBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;
    if (args is! Map<String, dynamic> || args['shopId'] == null) {
      Get.snackbar(
        'Error',
        'shopId tidak tersedia.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.offAllNamed('/'); // Alihkan ke halaman utama atau halaman error
      return;
    }

    final String shopId = args['shopId'];
    print('KelolaAkunPegawaiBinding: shopId = $shopId');

    Get.lazyPut<KelolaAkunPegawaiController>(
      () => KelolaAkunPegawaiController(shopId: shopId),
    );
  }
}
