// views/struk_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../all_activity/models/history_model.dart';
import '../../all_activity/services/history_service.dart';

class StrukPage extends StatelessWidget {
  final HistoryService _historyService = HistoryService();

  // Hapus keyword 'const' dari konstruktor
  StrukPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null || args['transactionId'] == null || args['shopId'] == null) {
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

    final String transactionId = args['transactionId'];
    final String shopId = args['shopId'];

    // Mengambil data transaksi berdasarkan transactionId
    return FutureBuilder<History?>(
      future: _historyService.getHistoryByTransactionId(shopId, transactionId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('STRUK PEMBAYARAN'),
              backgroundColor: Colors.blueGrey,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('STRUK PEMBAYARAN'),
              backgroundColor: Colors.blueGrey,
            ),
            body: const Center(child: Text('Struk tidak ditemukan.')),
          );
        } else {
          final History history = snapshot.data!;
          final String username = history.username;
          final String email = history.email;
          final DateTime timestamp = history.timestamp;
          final String activity = history.activity;
          final List<ProductDetail> products = history.products;

          String formattedDate = '${timestamp.day}-${timestamp.month}-${timestamp.year} ${timestamp.hour}:${timestamp.minute}:${timestamp.second} WIB';

          // Menentukan metode pembayaran berdasarkan activity
          String paymentMethod = history.activity.contains('cash') ? 'CASH' : 'DEBIT';
          // Mengambil totalPembayaran menggunakan regex
          RegExp regExp = RegExp(r'sebesar Rp(\d+)');
          Match? match = regExp.firstMatch(history.activity);
          int totalPembayaran = match != null ? int.parse(match.group(1)!) : 0;

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
                _buildContent(context, username, email, formattedDate, transactionId, products, totalPembayaran, paymentMethod),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Ubah sesuai kebutuhan
      ),
    );
  }

  Widget _buildContent(BuildContext context, String username, String email, String formattedDate, String transactionId, List<ProductDetail> products, int totalPembayaran, String paymentMethod) {
    return SingleChildScrollView(
      child: Center(
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
                  'TANGGAL :\n$formattedDate\n'
                  'NOMOR REFERENSI :\n$transactionId\n',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Daftar produk yang dibeli
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Jumlah: ${product.quantity}'),
                      trailing: Text('Rp${product.price * product.quantity}'),
                    );
                  },
                ),
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
      ),
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
