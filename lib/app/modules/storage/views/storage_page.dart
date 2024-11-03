import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/storage_controller.dart';
import '../models/product_model.dart';
import '../widgets/card_storage.dart'; // Pastikan widget ini didefinisikan

class StoragePage extends StatelessWidget {
  const StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    final StorageController controller = Get.find<StorageController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Storage', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<List<ProductModel>>(
          stream: controller.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // Menangani error dengan menampilkan pesan yang ramah pengguna
              return Center(
                child: Text(
                  'Terjadi kesalahan: ${snapshot.error}',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final products = snapshot.data ?? [];
            if (products.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada produk di toko ini.\nTekan tombol "+" untuk menambahkan produk.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return CardStorage(
                  itemName: product.name.isNotEmpty
                      ? product.name
                      : 'Produk Tidak Tersedia',
                  itemQuantity: '${product.quantity} pcs',
                  itemPrice: 'Rp ${product.price}',
                  imageUrl: product.imageUrl.isNotEmpty
                      ? product.imageUrl
                      : 'assets/default.png',
                  onEdit: () {
                    // Navigasi ke EditProdukPage menggunakan named route
                    Get.toNamed(
                      '/EditProduk',
                      arguments: {
                        'shopId': controller.shopId,
                        'productId': product.id,
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke TambahProdukPage menggunakan named route
          Get.toNamed(
            '/TambahProduk',
            arguments: {
              'shopId': controller.shopId,
            },
          );
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
