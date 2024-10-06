import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../views/home_page.dart';

class LoginController {
  void login(User user, BuildContext context) {
    if (user.username.isNotEmpty && user.password.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }
}