import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/home/views/login/pilih_tempat_kerja_page.dart';
import 'package:kasir_mobile_5/app/modules/home/views/login/pilih_toko_page.dart';
// Pastikan Anda memiliki halaman HomePage

class PilihModePage extends StatelessWidget {
  const PilihModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PILIH MODE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // Ganti dengan path gambar Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  _buildButton(
                    context,
                    icon: Icons.store,
                    label: 'PEMILIK TOKO',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PilihTokoPage()), // Ganti dengan nama kelas Home Anda
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildButton(
                    context,
                    icon: Icons.business_center,
                    label: 'PEGAWAI',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PilihTempatKerjaPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed, Color? buttonColor}) {
  return SizedBox(
    height: 250, // Menentukan tinggi tombol
    width: 350,  // Menentukan lebar tombol
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? const Color(0xFFD9D9D9), // Mengatur warna tombol
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // Mengatur radius sudut border tombol
        ),
        side: const BorderSide(
          color: Colors.blueGrey, // Mengatur warna border
          width: 2, // Mengatur ketebalan border
        ),
        minimumSize: const Size(200, 60), // Mengatur ukuran minimum tombol
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF28374C), size: 40),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF28374C),
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}

}
