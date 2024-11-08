import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KelolaAkunPegawaiController extends GetxController {
  final String shopId;

  KelolaAkunPegawaiController({required this.shopId});

  @override
  void onInit() {
    super.onInit();
    print('KelolaAkunPegawaiController initialized with shopId: $shopId');
  }

  // Tambahkan metode lain jika diperlukan
}
