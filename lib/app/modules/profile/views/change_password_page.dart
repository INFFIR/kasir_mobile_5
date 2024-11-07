// lib/modules/profile/change_password_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';
import '../controllers/profile_controller.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final ProfileController _profileController = Get.find();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Variabel untuk mengontrol visibilitas password
  bool _isOldPasswordObscured = true;
  bool _isNewPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  void _changePassword() async {
    String oldPassword = _oldPasswordController.text.trim();
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
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

    if (newPassword != confirmPassword) {
      Get.dialog(
        AlertDialog(
          title: const Text("Password Tidak Sama"),
          content: const Text("Password baru dan konfirmasi password tidak sama."),
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
      await _profileController.changePassword(oldPassword, newPassword);

      // Menampilkan pop-up dialog sukses
      Get.dialog(
        AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Password berhasil diubah!'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Menutup dialog
                Get.back(); // Kembali ke halaman profil
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'wrong-password') {
        message = "Password lama salah.";
      } else {
        message = e.message ?? "Terjadi kesalahan.";
      }
      Get.dialog(
        AlertDialog(
          title: const Text("Gagal"),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UBAH PASSWORD'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png', // Path gambar background
              fit: BoxFit.cover,
            ),
          ),
          // Form and elements with white background
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 350,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Password Lama
                      TextField(
                        controller: _oldPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan Password Lama:',
                          filled: true,
                          fillColor: Colors.grey.shade200.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isOldPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isOldPasswordObscured = !_isOldPasswordObscured;
                              });
                            },
                          ),
                        ),
                        obscureText: _isOldPasswordObscured,
                      ),
                      const SizedBox(height: 20),
                      // Password Baru
                      TextField(
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan Password Baru:',
                          filled: true,
                          fillColor: Colors.grey.shade200.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isNewPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isNewPasswordObscured = !_isNewPasswordObscured;
                              });
                            },
                          ),
                        ),
                        obscureText: _isNewPasswordObscured,
                      ),
                      const SizedBox(height: 20),
                      // Konfirmasi Password Baru
                      TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Ulangi Password Baru:',
                          filled: true,
                          fillColor: Colors.grey.shade200.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
                              });
                            },
                          ),
                        ),
                        obscureText: _isConfirmPasswordObscured,
                      ),
                      const SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: _changePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Ubah Password'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
