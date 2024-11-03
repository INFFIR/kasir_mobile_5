// views/struk_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../storage/models/product_model.dart';


class StrukPage extends StatelessWidget {
  const StrukPage({super.key});

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
    final Map<String, int> cartItems = Map<String, int>.from(args['cartItems']);
    final List<ProductModel> selectedProducts = List<ProductModel>.from(args['selectedProducts']);

    // Dapatkan tanggal dan waktu sekarang
    final DateTime now = DateTime.now();
    final String formattedDate = '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'STRUK PEMBAYARAN',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(context, paymentMethod, totalPembayaran, cartItems, selectedProducts, formattedDate),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Change to a solid background color if needed
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    String paymentMethod,
    int totalPembayaran,
    Map<String, int> cartItems,
    List<ProductModel> selectedProducts,
    String formattedDate,
  ) {
    return Center(
      child: Container(
        width: 350,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: Text(
                  '(NAMA TOKO)\n(ALAMAT TOKO)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'TANGGAL :\n$formattedDate WIB\n'
                'NOMOR REFERENSI :\nID XXX XXX XXX\n',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // List item transaksi
              ...selectedProducts.map((product) {
                int quantity = cartItems[product.id] ?? 0;
                int totalHarga = product.price * quantity;
                return _buildItemRow(
                  '$quantity x ${product.name}',
                  'Rp${product.price}',
                  'Rp$totalHarga',
                );
              }).toList(),
              const Divider(height: 30, thickness: 2),
              _buildTotalRow('TOTAL', 'Rp$totalPembayaran'),
              const SizedBox(height: 20),
              Text(
                'METODE PEMBAYARAN :\n$paymentMethod',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildButtonSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(String itemName, String itemPrice, String totalPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(itemName, style: const TextStyle(fontSize: 16))),
        Text(totalPrice, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildTotalRow(String label, String total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(total, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildButtonSection(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(
          context: context,
          label: 'KEMBALI KE BERANDA',
          color: Colors.orange,
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
