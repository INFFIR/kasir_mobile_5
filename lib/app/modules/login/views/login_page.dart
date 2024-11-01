// lib/modules/login/views/login_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController controller = Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
    // Mendengarkan perubahan pada savedEmail dan mengisi emailController
    ever(controller.savedEmail, (String email) {
      emailController.text = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form and elements
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 125), // Spasi di bagian atas
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Field Email
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Field Password
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Remember Me Checkbox
                  Obx(() => CheckboxListTile(
                        title: const Text("Remember Me"),
                        value: controller.rememberMe.value,
                        onChanged: (bool? value) {
                          if (value != null) {
                            controller.rememberMe.value = value;
                          }
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      )),
                  const SizedBox(height: 16),
                  // Tombol Login
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(21, 173, 180, 1),
                      ),
                      onPressed: () {
                        UserModel user = UserModel(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        controller.login(user);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Buat Akun dan Lupa Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(21, 173, 180, 1),
                          ),
                          onPressed: () {
                            Get.offNamed("/SignUp"); // Pastikan route sesuai
                          },
                          child: const Text(
                            "Buat Akun",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(21, 173, 180, 1),
                          ),
                          onPressed: () {
                            Get.toNamed("/LupaPassword"); // Pastikan route sesuai
                          },
                          child: const Text(
                            "Lupa Password",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 125), // Jarak antar tombol dan tombol persegi
                  // Tombol Login dengan Google (contoh)
                  SizedBox(
                    width: 75, // Ukuran persegi
                    height: 75,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Hilangkan padding agar gambar memenuhi tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200), // Sudut melengkung
                        ),
                      ),
                      onPressed: () {
                        // Aksi untuk tombol persegi (misalnya login dengan Google)
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200), // Pastikan gambar juga mengikuti sudut melengkung
                        child: Image.asset(
                          'assets/google.png', // Gambar untuk tombol
                          fit: BoxFit.cover, // Mengatur gambar memenuhi tombol
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
