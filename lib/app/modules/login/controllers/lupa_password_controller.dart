// lib/modules/lupa_password/lupa_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LupaPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetEmail() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      Get.dialog(
        AlertDialog(
          title: const Text("Input Kosong"),
          content: const Text("Email tidak boleh kosong."),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await Get.dialog(
        AlertDialog(
          title: const Text("Sukses"),
          content: const Text("Email reset password telah dikirim."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Tutup dialog
                Get.offNamed('/Login'); // Kembali ke halaman login
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        message = "Pengguna dengan email ini tidak ditemukan.";
      } else {
        message = e.message ?? "Terjadi kesalahan.";
      }
      Get.dialog(
        AlertDialog(
          title: const Text("Reset Password Gagal"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text("Error"),
          content: Text("Terjadi kesalahan: $e"),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
