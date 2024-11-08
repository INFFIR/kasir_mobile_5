import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PilihTempatKerjaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  // Observable list untuk menyimpan data tempat kerja
  var tempatKerjaList = <DocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTempatKerja();
  }

  // Mengambil data tempat kerja dari Firestore secara real-time
  void fetchTempatKerja() {
    _firestore
        .collection('employee_shops')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .listen((QuerySnapshot snapshot) async {
      List<DocumentSnapshot> shops = [];
      for (var doc in snapshot.docs) {
        DocumentSnapshot shopData =
            await _firestore.collection('shops').doc(doc['shopId']).get();
        shops.add(shopData);
      }
      tempatKerjaList.value = shops;
    });
  }

  // Menghapus tempat kerja
  Future<void> deleteTempatKerja(String shopId) async {
    try {
      await _firestore
          .collection('employee_shops')
          .doc(userId + '_' + shopId)
          .delete();
      Get.snackbar("Berhasil", "Tempat kerja berhasil dihapus",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus tempat kerja: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
