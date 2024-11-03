import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonMedium extends StatelessWidget {
  final String label;
  final IconData icon;
  final String routeName;
  final Map<String, dynamic>? arguments;
  final Color backgroundColor;

  const ButtonMedium({
    super.key,
    required this.label,
    required this.icon,
    required this.routeName,
    this.arguments,
    this.backgroundColor = const Color(0xFFD9D9D9),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        height: 150,
        width: 350,
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(routeName, arguments: arguments);
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
