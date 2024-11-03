// views/memilih_pembayaran_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/widgets/button_large.dart';
import '../../storage/models/product_model.dart';

class MemilihPembayaranPage extends StatelessWidget {
  const MemilihPembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null ||
        args['shopId'] == null ||
        args['cartItems'] == null ||
        args['selectedProducts'] == null ||
        args['totalPembayaran'] == null) {
      Get.snackbar(
        'Error',
        'Data pembayaran tidak lengkap.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.back();
      return Container();
    }

    final String shopId = args['shopId'];
    final Map<String, int> cartItems = Map<String, int>.from(args['cartItems']);
    final List<ProductModel> selectedProducts = List<ProductModel>.from(args['selectedProducts']);
    final int totalPembayaran = args['totalPembayaran'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'PILIH METODE PEMBAYARAN',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // Ganti dengan path gambar Anda
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  ButtonLarge(
                    icon: Icons.attach_money,
                    label: 'PEMBAYARAN MENGGUNAKAN CASH',
                    onPressed: () {
                      Get.toNamed('/KonfirmasiCash', arguments: {
                        'shopId': shopId,
                        'cartItems': cartItems,
                        'selectedProducts': selectedProducts,
                        'totalPembayaran': totalPembayaran,
                        'paymentMethod': 'CASH',
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ButtonLarge(
                    icon: Icons.credit_card,
                    label: 'PEMBAYARAN MENGGUNAKAN DEBIT',
                    onPressed: () {
                      Get.toNamed('/KonfirmasiDebit', arguments: {
                        'shopId': shopId,
                        'cartItems': cartItems,
                        'selectedProducts': selectedProducts,
                        'totalPembayaran': totalPembayaran,
                        'paymentMethod': 'DEBIT',
                      });
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
}
