// components/widgets/activity_button_widget.dart
import 'package:flutter/material.dart';

class ActivityButtonWidget extends StatelessWidget {
  final String username;
  final String email;
  final String date;
  final String time;
  final String activity;
  final VoidCallback onPressed;

  const ActivityButtonWidget({
    Key? key,
    required this.username,
    required this.email,
    required this.date,
    required this.time,
    required this.activity,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        backgroundColor: Colors.blueAccent.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris atas: Username & Email di kiri, Waktu & Tanggal di kanan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Username dan Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              // Waktu dan Tanggal
              Text(
                '$date $time',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Informasi Aktivitas
          Text(
            activity,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
