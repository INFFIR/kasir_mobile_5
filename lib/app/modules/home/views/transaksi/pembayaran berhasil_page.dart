import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/home/views/transaksi/struk_page.dart';
import '../homepage/home_page.dart';

void main() {
  runApp(const MaterialApp(
    home: PembayaranberhasilPage(),
  ));
}

class PembayaranberhasilPage extends StatefulWidget {
  const PembayaranberhasilPage({super.key});

  @override
  _PembayaranBerhasilPageState createState() => _PembayaranBerhasilPageState();
}

class _PembayaranBerhasilPageState extends State<PembayaranberhasilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'KONFIRMASI PEMBAYARAN CASH',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(context),
        ],
      ),
    );
  }

  // Method to build the background of the page
  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Method to build the main content of the page
  Widget _buildContent(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFDDE6ED).withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            const Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            const Text(
              'TRANSAKSI BERHASIL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'PEMBAYARAN MENGGUNAKAN CASH',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            _buildTotalPaymentSection(),
            const SizedBox(height: 30),
            _buildButtonSection(),
          ],
        ),
      ),
    );
  }

  // Method to build the total payment section
  Widget _buildTotalPaymentSection() {
    return Center(
      child: Container(
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SEBESAR:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rp60.000',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1),
          ],
        ),
      ),
    );
  }

  // Method to build the button section
  Widget _buildButtonSection() {
    return Column(
      children: [
        _buildActionButton(
          context: context,
          label: 'LIHAT STRUK',
          color: Colors.orange,
          onPressed: () {
            // Add your action here
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StrukPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildActionButton(
          context: context,
          label: 'KEMBALI KE BERANDA',
          color: Colors.red,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ],
    );
  }

  // Method to build individual action buttons
  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 350,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
