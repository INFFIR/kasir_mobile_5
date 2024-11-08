import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../all_activity/services/history_service.dart';

class DetailKaryawanController extends GetxController {
  final String employeeId;
  final String shopId;
  final HistoryService historyService;

  DetailKaryawanController({
    required this.employeeId,
    required this.shopId,
    required this.historyService,
  });

  @override
  void onInit() {
    super.onInit();
    print('DetailKaryawanController initialized with employeeId: $employeeId, shopId: $shopId');
  }

  Future<void> deleteEmployee(BuildContext context) async {
    print('deleteEmployee called');
    final TextEditingController _passwordController = TextEditingController();

    Get.defaultDialog(
      title: 'Konfirmasi Penghapusan',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Masukkan password untuk mengonfirmasi penghapusan akun.'),
          const SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      textCancel: 'Batal',
      textConfirm: 'Hapus',
      onCancel: () {
        print('Delete dialog canceled');
      },
      onConfirm: () async {
        print('Delete confirmation dialog confirmed');
        String enteredPassword = _passwordController.text.trim();
        print('Entered Password: $enteredPassword');

        if (enteredPassword.isEmpty) {
          print('Password is empty');
          Get.snackbar(
            'Error',
            'Password tidak boleh kosong.',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
          return;
        }

        try {
          User? user = FirebaseAuth.instance.currentUser;
          print('Current User: $user');
          if (user == null) {
            throw FirebaseAuthException(
              code: 'no-current-user',
              message: 'Tidak ada pengguna yang sedang login.',
            );
          }

          String? email = user.email;
          print('User Email: $email');
          if (email == null) {
            throw FirebaseAuthException(
              code: 'no-email',
              message: 'Akun pengguna tidak memiliki email yang terdaftar.',
            );
          }

          AuthCredential credential = EmailAuthProvider.credential(
              email: email, password: enteredPassword);
          print('Reauthenticating user');
          await user.reauthenticateWithCredential(credential);
          print('User reauthenticated successfully');

          print('Deleting employee document');
          await FirebaseFirestore.instance
              .collection('employee_shops')
              .doc('${employeeId}_$shopId')
              .delete();
          print('Employee document deleted');

          print('Logging activity');
          await historyService.logActivity(
            shopId,
            'Pegawai dengan ID $employeeId telah dihapus dari toko.',
          );
          print('Activity logged');

          Get.back();

          print('Navigating to /KelolaAkun with shopId: $shopId');
          Get.offAllNamed('/KelolaAkun', arguments: {'shopId': shopId});
        } on FirebaseAuthException catch (e) {
          print('FirebaseAuthException: ${e.code} - ${e.message}');
          Get.snackbar(
            'Error',
            e.message ?? 'Terjadi kesalahan saat mengautentikasi ulang.',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        } catch (e) {
          print('Exception: $e');
          Get.snackbar(
            'Berhasil',
            'Karyawan telah di hapus',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
          );
        }
      },
    );
  }
}
