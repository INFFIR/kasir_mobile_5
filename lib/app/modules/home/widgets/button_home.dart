// lib/app/modules/components/custom_button.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonHome extends StatelessWidget {
  final String label;
  final IconData icon;
  final String routeName;
  final Color backgroundColor;

  const ButtonHome({
    super.key,
    required this.label,
    required this.icon,
    required this.routeName,
    this.backgroundColor = const Color(0xFFD9D9D9),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10), // Menggunakan margin yang diberikan
      child: SizedBox(
        height: 150,
        width: 350,
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(routeName);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Icon(
                    icon,
                    color: const Color(0xFF28374C),
                    size: 40,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Center(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF28374C),
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
