import 'package:flutter/material.dart';
import 'package:get/get.dart';

void handleException(dynamic e) {
  Get.snackbar(
    'Error',
    e?.toString() ?? 'Terjadi kesalahan yang tidak diketahui.',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.redAccent,
    colorText: Colors.white,
  );
}

void handleEmptyData(String fieldName) {
  Get.snackbar(
    'Peringatan',
    '$fieldName tidak boleh kosong.',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.orangeAccent,
    colorText: Colors.white,
  );
}
