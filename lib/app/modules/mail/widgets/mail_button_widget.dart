// file: lib/widgets/mail_button_widget.dart

import 'package:flutter/material.dart';

class MailButtonWidget extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final VoidCallback onPressed;

  const MailButtonWidget({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF7F2FA), // Warna tombol
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Mengatur border radius
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Mengatur teks di kiri
        children: [
          Row( // Header di dalam tombol
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Warna teks
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Warna teks
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Jarak antara header dan teks
          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
