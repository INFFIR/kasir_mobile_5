import 'package:flutter/material.dart';

class ButtonProfile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? buttonColor;

  const ButtonProfile({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10), // Menambahkan margin 20 di setiap sisi
      child: SizedBox(
        height: 75,
        width: 350,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? const Color(0xFFD9D9D9), // Gunakan buttonColor jika ada
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Icon(icon, color: const Color(0xFF28374C), size: 30),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 7,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF28374C),
                    fontSize: 20,
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
