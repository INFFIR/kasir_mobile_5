// lib/widgets/button_large.dart
import 'package:flutter/material.dart';

class ButtonLarge extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? buttonColor;

  const ButtonLarge({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Menentukan tinggi tombol
      width: 350,  // Menentukan lebar tombol
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? const Color(0xFFD9D9D9), // Mengatur warna tombol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Mengatur radius sudut border tombol
          ),
          side: const BorderSide(
            color: Colors.blueGrey, // Mengatur warna border
            width: 2, // Mengatur ketebalan border
          ),
          minimumSize: const Size(200, 60), // Mengatur ukuran minimum tombol
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF28374C), size: 40),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF28374C),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
