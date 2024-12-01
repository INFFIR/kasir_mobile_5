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
    url: 'https://kxpkkvtklojzypaqnkqf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt4cGtrdnRrbG9qenlwYXFua3FmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzA0NTU5ODAsImV4cCI6MjA0NjAzMTk4MH0.LlxFgyjUQVblJ9OuKeXPX00SAMveVV9lAoMTehf38G8',
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
