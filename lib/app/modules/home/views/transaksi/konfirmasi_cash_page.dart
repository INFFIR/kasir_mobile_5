import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MaterialApp(
    home: KonfirmasiCashPage(),
  ));
}

class KonfirmasiCashPage extends StatefulWidget {
  const KonfirmasiCashPage({super.key});

  @override
  _KonfirmasiCashPageState createState() => _KonfirmasiCashPageState();
}

class _KonfirmasiCashPageState extends State<KonfirmasiCashPage> {
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
      bottomNavigationBar: _buildBottomNavigationBar(context),
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
        color: const Color(0xFFDDE6ED).withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPaymentInfo(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildButtonSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build the payment information section
  Widget _buildPaymentInfo() {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Center(
            child: Icon(
              Icons.attach_money,
              size: 100,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'PEMBAYARAN MENGGUNAKAN CASH',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(height: 40),
          _buildTotalPaymentSection(),
          const SizedBox(height: 50),
        ],
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
                  'SEBESAR :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rp60.000',
                  style: TextStyle(
                    fontSize: 18,
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

  // Method to build the bottom navigation bar
  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blueGrey,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_back_ios_new),
          label: 'Back',
        ),
      ],
      onTap: (index) {
        _onBottomNavigationTap(index, context);
      },
    );
  }

  // Method to handle bottom navigation tap events
  void _onBottomNavigationTap(int index, BuildContext context) {
          if (index == 0) {
            Get.toNamed('/profile'); // Mengganti dengan route untuk ProfilePage
          } else if (index == 1) {
            Get.offNamed('/home'); // Mengganti dengan route untuk HomePage
          } else if (index == 2) {
            Get.back(); // Menggunakan Get.back() untuk kembali ke halaman sebelumnya
          }
  }

  // Method to build the button section
  Widget _buildButtonSection({double buttonWidth = 350}) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: buttonWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          _buildActionButton(
            context: context,
            label: 'Konfirmasi',
            color: Colors.orange,
            onPressed: () {

            Get.toNamed('/pembayaranBerhasil'); // Mengganti dengan route untuk ProfilePage
            },
          ),
          const SizedBox(height: 10),
          _buildActionButton(
            context: context,
            label: 'Batal',
            color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // Method to build individual action buttons
  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required Color color,
    required VoidCallback onPressed,
    double buttonWidth = 350,
    double buttonHeight = 50,
  }) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
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
