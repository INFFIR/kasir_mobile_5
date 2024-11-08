// controllers/pilih_tempat_kerja_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PilihTempatKerjaController extends GetxController {
  // Reference ke koleksi 'tempat_kerja' di Firestore
  final CollectionReference tempatKerjaCollection =
      FirebaseFirestore.instance.collection('tempat_kerja');

  // Observable list untuk menyimpan data tempat kerja
  var tempatKerjaList = <DocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTempatKerja();
  }

  // Mengambil data tempat kerja dari Firestore secara real-time
  void fetchTempatKerja() {
    tempatKerjaCollection.snapshots().listen((QuerySnapshot snapshot) {
      tempatKerjaList.value = snapshot.docs;
    });
  }

  // Menampilkan dialog konfirmasi sebelum menghapus tempat kerja
  void showDeleteConfirmation(BuildContext context, String tempatKerjaId, String tempatKerjaName) {
    Get.defaultDialog(
      title: "Hapus Tempat Kerja",
      middleText: "Apakah kamu yakin ingin menghapus tempat kerja '$tempatKerjaName'?",
      textConfirm: "Ya",
      textCancel: "Tidak",
      confirmTextColor: Colors.white,
      onConfirm: () {
        deleteTempatKerja(tempatKerjaId);
        Get.back();
      },
      onCancel: () {},
    );
  }

  // Menghapus tempat kerja dari Firestore
  Future<void> deleteTempatKerja(String tempatKerjaId) async {
    try {
      await tempatKerjaCollection.doc(tempatKerjaId).delete();
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
