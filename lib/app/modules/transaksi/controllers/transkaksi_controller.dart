// controllers/transaksi_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../storage/models/product_model.dart';
import '../../storage/utils/storage_exception_handler.dart';

class TransaksiController extends GetxController {
  late String shopId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var products = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs; // Produk yang sudah difilter
  var cartItems = <String, int>{}.obs; // Menyimpan productId dan jumlah pembelian

  var searchQuery = ''.obs; // Query pencarian

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null || args['shopId'] == null) {
      Get.snackbar(
        'Error',
        'shopId tidak ditemukan. Pastikan Anda mengirim shopId saat navigasi.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.back();
    } else {
      shopId = args['shopId'];
      fetchProducts();
      // Menambahkan listener untuk searchQuery
      searchQuery.listen((query) {
        filterProducts(query);
      });
    }
  }

  void fetchProducts() {
    try {
      _firestore
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .snapshots()
          .listen((snapshot) {
        products.value = snapshot.docs
            .map((doc) => ProductModel.fromMap(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList();
        // Setelah mendapatkan produk, lakukan filter awal
        filterProducts(searchQuery.value);
      });
    } catch (e) {
      handleException(e);
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      // Jika query kosong, tampilkan semua produk
      filteredProducts.value = List<ProductModel>.from(products);
    } else {
      // Filter produk berdasarkan nama yang mengandung query
      filteredProducts.value = products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void addToCart(String productId, int quantity) {
    // Cari produk berdasarkan ID
    ProductModel? product;
    try {
      product = products.firstWhere((p) => p.id == productId);
    } catch (e) {
      product = null;
    }

    if (product == null) {
      handleException('Produk tidak ditemukan');
      return;
    }

    if (quantity < 0) {
      handleException('Jumlah pembelian tidak boleh negatif');
      return;
    }
    if (quantity > product.quantity) {
      handleException('Jumlah pembelian melebihi stok tersedia');
      return;
    }
    if (quantity > 0) {
      cartItems[productId] = quantity;
    } else {
      cartItems.remove(productId);
    }
  }
}
