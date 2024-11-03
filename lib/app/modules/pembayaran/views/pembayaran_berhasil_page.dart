// views/pembayaran_berhasil_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PembayaranBerhasilPage extends StatelessWidget {
  const PembayaranBerhasilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null ||
        args['shopId'] == null ||
        args['selectedProducts'] == null ||
        args['cartItems'] == null ||
        args['totalPembayaran'] == null ||
        args['paymentMethod'] == null) {
      Get.snackbar(
        'Error',
        'Data transaksi tidak lengkap.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.offNamed('/Home');
      return Container();
    }

    final String paymentMethod = args['paymentMethod'];
    final int totalPembayaran = args['totalPembayaran'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'PEMBAYARAN BERHASIL',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(context, paymentMethod, totalPembayaran),
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
  Widget _buildContent(BuildContext context, String paymentMethod, int totalPembayaran) {
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
            Text(
              'PEMBAYARAN MENGGUNAKAN $paymentMethod',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            _buildTotalPaymentSection(totalPembayaran),
            const SizedBox(height: 30),
            _buildButtonSection(context),
          ],
        ),
      ),
    );
  }

  // Method to build the total payment section
  Widget _buildTotalPaymentSection(int totalPembayaran) {
    return Center(
      child: Container(
        width: 350,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'SEBESAR:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Rp$totalPembayaran',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1),
          ],
        ),
      ),
    );
  }

  // Method to build the button section
  Widget _buildButtonSection(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(
          context: context,
          label: 'LIHAT STRUK',
          color: Colors.orange,
          onPressed: () {
            // Add your action here
            Get.offNamed('/Struk', arguments: Get.arguments);
          },
        ),
        const SizedBox(height: 10),
        _buildActionButton(
          context: context,
          label: 'KEMBALI KE BERANDA',
          color: Colors.red,
          onPressed: () {
            Get.offNamed('/Home');
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
