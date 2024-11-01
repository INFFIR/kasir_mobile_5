// lib/modules/login/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Routes/app_routes.dart';
import '../models/user_model.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observable untuk "Remember Me"
  RxBool rememberMe = false.obs;
  RxString savedEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedEmail();
  }

  // Memuat email yang disimpan jika ada
  Future<void> _loadSavedEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('saved_email');
    if (email != null && email.isNotEmpty) {
      savedEmail.value = email;
      rememberMe.value = true;
    }
  }

  // Metode login
  Future<void> login(UserModel user) async {
    if (user.email.isEmpty || user.password.isEmpty) {
      _showLoginFailedDialog("Email dan password tidak boleh kosong.");
      return;
    }

    try {
      // Sign in pengguna dengan email dan password
      await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Handle Remember Me
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (rememberMe.value) {
        await prefs.setString('saved_email', user.email);
      } else {
        await prefs.remove('saved_email');
      }

      // Navigasi ke halaman Pilih Mode setelah login berhasil
      Get.offNamed(AppRoutes.pilihMode);
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'user-not-found') {
        message = "Pengguna tidak ditemukan.";
      } else if (e.code == 'wrong-password') {
        message = "Password salah.";
      } else {
        message = e.message ?? "Terjadi kesalahan.";
      }
      _showLoginFailedDialog(message);
    } catch (e) {
      _showLoginFailedDialog("Terjadi kesalahan: $e");
    }
  }

  // Menampilkan dialog gagal login
  void _showLoginFailedDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text("Login Gagal"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Get.back(); // Tutup dialog
            },
          ),
        ],
      ),
    );
  }
}
