// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'firebase_options.dart'; // Import konfigurasi Firebase (dihasilkan oleh Firebase CLI)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform,
  );
  runApp(const MyApp());

  await Supabase.initialize(
    url: 'https://naqlqkuowrnmbloxttmn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hcWxxa3Vvd3JubWJsb3h0dG1uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI4ODY1NjQsImV4cCI6MjA0ODQ2MjU2NH0.jZbwSPILAMu9DUf1FMVJxj5F5MbzjVdF9Ep9ChfQXLo',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Store App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.login,
      // Inisialisasi rute pertama
      getPages: AppPages.pages,
      // Daftar rute
      debugShowCheckedModeBanner: false,
    );
  }
}