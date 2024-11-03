// views/transaksi_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/widgets/bottom_nav_bar.dart';
import '../../components/widgets/search_bar_widget.dart';
import '../../storage/models/product_model.dart';
import '../controllers/transkaksi_controller.dart';


class TransaksiPage extends StatelessWidget {
  const TransaksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TransaksiController controller = Get.find<TransaksiController>();
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'TRANSAKSI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: Colors.white,
            onPressed: () {
              // Aksi untuk menyimpan item
              if (controller.cartItems.isNotEmpty) {
                Get.toNamed('/CekPembelian', arguments: {
                  'shopId': controller.shopId,
                  'cartItems': controller.cartItems,
                  'products': controller.products,
                });
              } else {
                Get.snackbar(
                  'Peringatan',
                  'Anda belum memilih produk apa pun.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.orangeAccent,
                  colorText: Colors.white,
                );
              }
            },
          ),
        ],
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
          Column(
            children: [
              // Menggunakan SearchBarWidget
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchBarWidget(
                  controller: searchController,
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                  onClear: () {
                    searchController.clear();
                    controller.searchQuery.value = '';
                  },
                ),
              ),
              // List of products
              Expanded(
                child: Obx(() {
                  if (controller.filteredProducts.isEmpty) {
                    return const Center(child: Text('Produk tidak ditemukan.'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      var product = controller.filteredProducts[index];
                      return _buildItemCard(
                        controller: controller,
                        product: product,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildItemCard({
    required TransaksiController controller,
    required ProductModel product,
  }) {
    final TextEditingController jumlahPembelianController = TextEditingController(
      text: controller.cartItems[product.id]?.toString() ?? '0',
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0), // Atur radius card di sini
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Gambar produk
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // Atur radius gambar di sini
              child: product.imageUrl.isNotEmpty
                  ? Image.network(
                      product.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/default.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/default.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 16),
            // Informasi produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama barang di kiri atas
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Deskripsi barang di tengah
                  Text(
                    product.description,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  // Jumlah stok di kiri bawah
                  Text('${product.quantity} pcs'),
                ],
              ),
            ),
            // Kolom untuk harga dan ikon plus/minus
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Harga di kanan atas
                Text(
                  'Rp ${product.price}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Tombol pengurangan dan penambahan jumlah barang
                Row(
                  children: [
                    // Tombol pengurangan jumlah barang di kiri
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        int currentJumlah =
                            int.tryParse(jumlahPembelianController.text) ?? 0;
                        if (currentJumlah > 0) {
                          currentJumlah--;
                          jumlahPembelianController.text = currentJumlah.toString();
                          controller.addToCart(product.id, currentJumlah);
                        }
                      },
                    ),
                    // TextField untuk input jumlah barang
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: TextField(
                        controller: jumlahPembelianController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                        onChanged: (value) {
                          int quantity = int.tryParse(value) ?? 0;
                          controller.addToCart(product.id, quantity);
                        },
                      ),
                    ),
                    // Tombol penambahan jumlah barang di kanan
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        int currentJumlah =
                            int.tryParse(jumlahPembelianController.text) ?? 0;
                        currentJumlah++;
                        jumlahPembelianController.text = currentJumlah.toString();
                        controller.addToCart(product.id, currentJumlah);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
