import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../views/homepage/home_page.dart'; // Pastikan untuk mengimpor HomePage

class LoginController {
  void login(User user, BuildContext context) {
    // Cek jika username dan password tidak kosong
    if (user.username.isNotEmpty && user.password.isNotEmpty) {
      // Contoh validasi username dan password
      if (user.username == "a" && user.password == "a") {
        // Login berhasil, navigasi ke HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        // Jika login gagal, tampilkan dialog
        _showLoginFailedDialog(context);
      }
    } else {
      // Tampilkan dialog jika username atau password kosong
      _showEmptyFieldsDialog(context);
    }
  }

  // Fungsi untuk menampilkan dialog pop-up ketika login gagal
  void _showLoginFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Gagal"),
          content: const Text("Username atau password salah. Silakan coba lagi."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan dialog jika username atau password kosong
  void _showEmptyFieldsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Input Kosong"),
          content: const Text("Username dan password tidak boleh kosong."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
          ],
        );
      },
    );
  }
}
