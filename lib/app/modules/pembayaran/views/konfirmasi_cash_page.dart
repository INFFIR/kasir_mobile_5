// views/konfirmasi_cash_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../all_activity/models/history_model.dart';
import '../../all_activity/services/history_service.dart';
import '../../storage/models/product_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

class KonfirmasiCashPage extends StatefulWidget {
  const KonfirmasiCashPage({super.key});

  @override
  _KonfirmasiCashPageState createState() => _KonfirmasiCashPageState();
}

class _KonfirmasiCashPageState extends State<KonfirmasiCashPage> {
  late String shopId;
  late Map<String, int> cartItems;
  late List<ProductModel> selectedProducts;
  late int totalPembayaran;
  late String paymentMethod;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HistoryService _historyService = HistoryService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null ||
        args['shopId'] == null ||
        args['cartItems'] == null ||
        args['selectedProducts'] == null ||
        args['totalPembayaran'] == null ||
        args['paymentMethod'] == null) {
      Get.snackbar(
        'Error',
        'Data pembayaran tidak lengkap.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.back();
    } else {
      shopId = args['shopId'];
      cartItems = Map<String, int>.from(args['cartItems']);
      selectedProducts = List<ProductModel>.from(args['selectedProducts']);
      totalPembayaran = args['totalPembayaran'];
      paymentMethod = args['paymentMethod'];
    }
  }

  Future<void> processPayment() async {
    try {
      // Memperbarui stok produk
      for (var product in selectedProducts) {
        int purchasedQuantity = cartItems[product.id] ?? 0;
        int newQuantity = product.quantity - purchasedQuantity;

        await _firestore
            .collection('shops')
            .doc(shopId)
            .collection('products')
            .doc(product.id)
            .update({'quantity': newQuantity});
      }

      // Membuat transactionId
      String transactionId = _generateTransactionId();

      // Mencatat aktivitas transaksi
      String username = _auth.currentUser?.displayName ?? 'User';
      String email = _auth.currentUser?.email ?? 'email@example.com';

      // Membuat daftar produk detail
      List<ProductDetail> productDetails = selectedProducts.map((product) {
        return ProductDetail(
          id: product.id,
          name: product.name,
          quantity: cartItems[product.id] ?? 0,
          price: product.price,
        );
      }).toList();

      History history = History(
        id: '',
        username: username,
        email: email,
        timestamp: DateTime.now(),
        activity:
            'Melakukan pembayaran cash sebesar Rp$totalPembayaran',
        transactionId: transactionId, // Menambahkan transactionId
        products: productDetails, // Sertakan produk
      );

      await _historyService.addHistory(shopId, history);

      // Navigasi ke halaman pembayaran berhasil
      Get.offNamed('/PembayaranBerhasil', arguments: {
        'shopId': shopId,
        'selectedProducts': selectedProducts,
        'cartItems': cartItems,
        'totalPembayaran': totalPembayaran,
        'paymentMethod': paymentMethod,
        'transactionId': transactionId,
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat memproses pembayaran.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  String _generateTransactionId() {
    // Implementasikan logika pembuatan transactionId sesuai kebutuhan
    // Contoh sederhana menggunakan timestamp
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'SEBESAR :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Rp$totalPembayaran',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
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
            label: 'KONFIRMASI PEMBAYARAN',
            color: Colors.orange,
            onPressed: () {
              processPayment();
            },
          ),
          const SizedBox(height: 10),
          _buildActionButton(
            context: context,
            label: 'BATALKAN',
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
