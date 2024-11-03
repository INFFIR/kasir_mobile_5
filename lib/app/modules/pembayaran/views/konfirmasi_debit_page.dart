// views/konfirmasi_debit_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../storage/models/product_model.dart';

class KonfirmasiDebitPage extends StatefulWidget {
  const KonfirmasiDebitPage({super.key});

  @override
  _KonfirmasiDebitPageState createState() => _KonfirmasiDebitPageState();
}

class _KonfirmasiDebitPageState extends State<KonfirmasiDebitPage> {
  late String shopId;
  late Map<String, int> cartItems;
  late List<ProductModel> selectedProducts;
  late int totalPembayaran;
  late String paymentMethod;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

      // Menyimpan transaksi (opsional)
      // Anda bisa menambahkan logika untuk menyimpan detail transaksi ke Firestore

      // Navigasi ke halaman pembayaran berhasil
      Get.offNamed('/PembayaranBerhasil', arguments: {
        'shopId': shopId,
        'selectedProducts': selectedProducts,
        'cartItems': cartItems,
        'totalPembayaran': totalPembayaran,
        'paymentMethod': paymentMethod,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'KONFIRMASI PEMBAYARAN DEBIT',
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
              Icons.credit_card,
              size: 100,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'PEMBAYARAN MENGGUNAKAN DEBIT',
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
          const SizedBox(height: 20),
          _buildBankInfoSection(),
          const SizedBox(height: 20),
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

  // Method to build the bank info section
  Widget _buildBankInfoSection() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'BANK : BCA',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'NO REKENING :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // This is the white box containing the account number and "SALIN" button
          Container(
            width: 350,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '1234 5678 9012 3456',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        // Add copy functionality
                        Clipboard.setData(const ClipboardData(text: '1234567890123456'));
                        Get.snackbar(
                          'Info',
                          'Nomor rekening telah disalin',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                      child: const Text(
                        'SALIN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
