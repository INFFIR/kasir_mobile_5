// lib/modules/sign_up/sign_up_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String username = usernameController.text.trim();

    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      Get.dialog(
        AlertDialog(
          title: const Text("Input Kosong"),
          content: const Text("Semua field harus diisi."),
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
      // Registrasi pengguna dengan email dan password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Simpan username ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'username': username,
        'email': email,
        'role': 'user', // Default role
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Tampilkan dialog sukses
      await Get.dialog(
        AlertDialog(
          title: const Text("Registrasi Berhasil"),
          content: const Text("Akun kamu telah berhasil dibuat."),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Tutup dialog
                Get.offNamed('/Login'); // Navigasi ke halaman login
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'weak-password') {
        message = "Password terlalu lemah.";
      } else if (e.code == 'email-already-in-use') {
        message = "Email sudah digunakan.";
      } else {
        message = e.message ?? "Terjadi kesalahan.";
      }
      Get.dialog(
        AlertDialog(
          title: const Text("Registrasi Gagal"),
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
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
