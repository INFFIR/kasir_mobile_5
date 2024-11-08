import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PilihTokoController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to fetch shops owned by the current user
  Stream<QuerySnapshot> get shops {
    String userId = _auth.currentUser!.uid;
    return _firestore
        .collection('shops')
        .where('ownerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Method to delete a shop
  Future<void> deleteShop(String shopId) async {
    try {
      // Hapus data terkait toko, seperti employee_shops
      await _firestore
          .collection('employee_shops')
          .where('shopId', isEqualTo: shopId)
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      await _firestore.collection('shops').doc(shopId).delete();
      Get.snackbar(
        'Berhasil',
        'Toko dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus toko: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // Method to show the delete confirmation dialog
  void showDeleteConfirmation(BuildContext context, String shopId, String shopName) {
    final TextEditingController confirmationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Penghapusan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Ketikkan ulang nama toko untuk mengonfirmasi penghapusan:'),
              const SizedBox(height: 10),
              TextField(
                controller: confirmationController,
                decoration: const InputDecoration(
                  labelText: 'Nama Toko',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                String inputName = confirmationController.text.trim();
                if (inputName == shopName) {
                  deleteShop(shopId);
                  Navigator.of(context).pop(); // Close the dialog after deletion
                } else {
                  Get.snackbar(
                    'Error',
                    'Nama toko tidak cocok',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
