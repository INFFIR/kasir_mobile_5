// views/pembayaran_berhasil_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../all_activity/services/history_service.dart';

import 'package:firebase_auth/firebase_auth.dart';

class PembayaranBerhasilPage extends StatelessWidget {
  final HistoryService _historyService = HistoryService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Hapus keyword 'const' dari konstruktor
  PembayaranBerhasilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null ||
        args['shopId'] == null ||
        args['selectedProducts'] == null ||
        args['cartItems'] == null ||
        args['totalPembayaran'] == null ||
        args['paymentMethod'] == null ||
        args['transactionId'] == null) {
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

    final String shopId = args['shopId'];
    final String paymentMethod = args['paymentMethod'];
    final int totalPembayaran = args['totalPembayaran'];
    final String transactionId = args['transactionId'];

    // Mencatat aktivitas transaksi di sini jika belum dicatat di controller
    // Namun, dalam contoh sebelumnya sudah dicatat di controller

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
          _buildContent(context, paymentMethod, totalPembayaran, transactionId),
        ],
      ),
    );
  }

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

  Widget _buildContent(
      BuildContext context, String paymentMethod, int totalPembayaran, String transactionId) {
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
            _buildButtonSection(context, transactionId),
          ],
        ),
      ),
    );
  }

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

  Widget _buildButtonSection(BuildContext context, String transactionId) {
    return Column(
      children: [
        _buildActionButton(
          context: context,
          label: 'LIHAT STRUK',
          color: Colors.orange,
          onPressed: () {
            Get.toNamed('/Struk', arguments: {
              'shopId': Get.arguments['shopId'],
              'transactionId': transactionId,
            });
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
