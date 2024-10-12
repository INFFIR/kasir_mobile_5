import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import './Routes/app_pages.dart'; // Import app_pages
import './Routes/app_routes.dart'; // Import app_routes

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetX's GetMaterialApp
      title: 'Login Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.login, // Initialize the first route
      getPages: AppPages.routes, // Use GetX pages for routing
    );
  }
}
