import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  _LupaPasswordPageState createState() => _LupaPasswordPageState();
}

class _LupaPasswordPageState extends State<LupaPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png', // Ganti dengan path gambar Anda
              fit: BoxFit.cover, // Agar gambar menutupi seluruh halaman
            ),
          ),
          // Form and elements with white background
          Center(
            child: SizedBox(
              width: 350, // Tentukan lebar yang diinginkan
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // Latar belakang putih dengan sedikit transparansi
                  borderRadius: BorderRadius.circular(12), // Sudut membulat
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Agar kolom hanya sebesar konten
                  children: [
                  const Text(
                    "Lupa Password",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _newPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Email :',
                        filled: true,
                        fillColor: Colors.grey.shade200.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Username :',
                        filled: true,
                        fillColor: Colors.grey.shade200.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 60),
                    ElevatedButton(
                      onPressed: (){
     
                        Get.offNamed('/LoginPage'); // Mengganti dengan route untuk HomePage
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Kirim'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
