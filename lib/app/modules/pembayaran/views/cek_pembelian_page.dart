// views/cek_pembelian_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../storage/models/product_model.dart';
class CekPembelianPage extends StatelessWidget {
  const CekPembelianPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null || args['cartItems'] == null || args['products'] == null) {
      Get.snackbar(
        'Error',
        'Data pembelian tidak ditemukan.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.back();
      return Container();
    }

    final String shopId = args['shopId'];
    final Map<String, int> cartItems = Map<String, int>.from(args['cartItems']);
    final List<ProductModel> products = List<ProductModel>.from(args['products']);

    // Filter produk yang ada di cartItems
    final List<ProductModel> selectedProducts = products
        .where((product) => cartItems.keys.contains(product.id))
        .toList();

    // Hitung total pembayaran
    int totalPembayaran = 0;
    for (var product in selectedProducts) {
      int quantity = cartItems[product.id] ?? 0;
      totalPembayaran += product.price * quantity;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'CEK PEMBELIAN',
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
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Container(
            margin: const EdgeInsets.all(20), // Margin 20 di setiap sudut
            color: const Color(0xFFDDE6ED).withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Padding dalam container
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedProducts.length,
                      itemBuilder: (context, index) {
                        var product = selectedProducts[index];
                        int quantity = cartItems[product.id] ?? 0;
                        return _buildItemCard(
                          product: product,
                          quantity: quantity,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTotalPembayaranSection(
                    totalPembayaran,
                    cartItems,
                    selectedProducts,
                    shopId,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          if (index == 0) {
            Get.toNamed('/Profile'); // Mengganti dengan route untuk ProfilePage
          } else if (index == 1) {
            Get.offNamed('/Home'); // Mengganti dengan route untuk HomePage
          } else if (index == 2) {
            Get.back(); // Menggunakan Get.back() untuk kembali ke halaman sebelumnya
          }
        },
      ),
    );
  }

  Widget _buildItemCard({
    required ProductModel product,
    required int quantity,
  }) {
    int totalHarga = product.price * quantity;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Gambar produk
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/default.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/default.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 16),
            // Informasi produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("TOTAL: Rp$totalHarga"),
                      Text("Qty: $quantity"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalPembayaranSection(
    int totalPembayaran,
    Map<String, int> cartItems,
    List<ProductModel> selectedProducts,
    String shopId,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Warna background putih
        borderRadius: BorderRadius.circular(30), // Border radius yang membulat
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL PEMBAYARAN',
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
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Warna tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Border radius untuk tombol
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16), // Padding untuk tombol
                  ),
                  onPressed: () {
                    // Aksi untuk membuat pesanan
                    Get.toNamed('/MemilihPembayaran', arguments: {
                      'shopId': shopId,
                      'cartItems': cartItems,
                      'selectedProducts': selectedProducts,
                      'totalPembayaran': totalPembayaran,
                    });
                  },
                  child: const Text(
                    'BUAT PESANAN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Warna teks tombol
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
