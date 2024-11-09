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
    url: 'https://wuujwzxuczpkvtnmkcys.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind1dWp3enh1Y3pwa3Z0bm1rY3lzIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczMTEzNjAzNCwiZXhwIjoyMDQ2NzEyMDM0fQ.q_LUQfmKSognvb7bui5i9OQfkz-Bvoclz6OlV3OmQ5c',
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
