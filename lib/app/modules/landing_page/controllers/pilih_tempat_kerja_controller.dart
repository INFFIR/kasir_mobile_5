// lib/app/modules/pilih_tempat_kerja/controllers/pilih_tempat_kerja_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../all_activity/services/history_service.dart'; // Pastikan path sesuai dengan struktur proyek Anda

class PilihTempatKerjaController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  // Observable list untuk menyimpan data tempat kerja
  var tempatKerjaList = <DocumentSnapshot>[].obs;

  // Inisialisasi HistoryService
  final HistoryService _historyService = HistoryService();

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

  // Menghapus tempat kerja dan mencatat aktivitas
  Future<void> deleteTempatKerja(String shopId) async {
    try {
      // Hapus tempat kerja dari koleksi employee_shops
      await _firestore
          .collection('employee_shops')
          .doc('${userId}_$shopId')
          .delete();

      // Mencatat aktivitas penghapusan tempat kerja
      await _historyService.logActivity(
        shopId,
        'Anda telah keluar dari tempat kerja dengan ID $shopId.',
      );

      // Menampilkan notifikasi berhasil
      Get.snackbar(
        "Berhasil",
        "Tempat kerja berhasil dihapus dan aktivitas telah dicatat.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // Menampilkan notifikasi gagal
      Get.snackbar(
        "Error",
        "Gagal menghapus tempat kerja: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
