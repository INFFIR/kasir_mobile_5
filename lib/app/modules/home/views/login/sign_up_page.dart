import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/home/views/login/login_page.dart';
import 'package:kasir_mobile_5/app/modules/home/views/login/lupa_password_page.dart';
import '../../controllers/login_controller.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController controller = LoginController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 125), // Spasi di bagian atas
                  const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(21, 173, 180, 1),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>  LoginPage()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>  LoginPage()),
                            );
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                          },
                          child: const Text(
                            "Login",
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
                              Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) =>  LupaPasswordPage()),
                            );
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
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
                        // Aksi untuk tombol persegi
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
