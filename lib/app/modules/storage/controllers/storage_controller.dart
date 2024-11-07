import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../utils/storage_exception_handler.dart';

class StorageController extends GetxController {
  late String shopId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null || args['shopId'] == null) {
      Get.snackbar(
        'Error',
        'shopId tidak ditemukan. Pastikan Anda mengirim shopId saat navigasi.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.back();
    } else {
      shopId = args['shopId'];
    }
  }

  Stream<List<ProductModel>> getProducts() {
    try {
      return _firestore
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => ProductModel.fromMap(
                doc.data(), doc.id))
            .toList();
      });
    } catch (e) {
      handleException(e);
      return const Stream.empty();
    }
  }
}
