import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../all_activity/services/history_service.dart';
import '../controllers/detail_karyawan_controller.dart';

class DetailKaryawanBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;
    if (args is! Map<String, dynamic>) {
      Get.snackbar(
        'Error',
        'Argumen tidak valid untuk DetailKaryawanPage',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.offAllNamed('/'); // Alihkan ke halaman utama atau halaman error
      return;
    }

    final String? employeeId = args['employeeId'];
    final String? shopId = args['shopId'];

    if (employeeId == null || shopId == null) {
      Get.snackbar(
        'Error',
        'employeeId atau shopId tidak tersedia.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.offAllNamed('/'); // Alihkan ke halaman utama atau halaman error
      return;
    }

    print('DetailKaryawanBinding: employeeId = $employeeId, shopId = $shopId');

    Get.lazyPut<DetailKaryawanController>(
      () => DetailKaryawanController(
        employeeId: employeeId,
        shopId: shopId,
        historyService: HistoryService(),
      ),
    );
  }
}
