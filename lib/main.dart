import 'package:flutter/material.dart';
import './Routes/app_pages.dart'; // Import app_pages
import './Routes/app_routes.dart'; // Import app_routes
import 'package:get/get.dart'; // Import GetX

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.login, // Inisialisasi rute pertama
      onGenerateRoute: AppPages.generateRoute, // Gunakan route generator
    );
  }
}
