// controllers/edit_produk_controller.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../all_activity/models/history_model.dart';
import '../../all_activity/services/history_service.dart';
import '../models/product_model.dart';
import '../utils/storage_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class EditProdukController extends GetxController {
  late String shopId;
  late String productId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final HistoryService _historyService = HistoryService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Initialize Supabase client
  final supabase.SupabaseClient _supabase = supabase.Supabase.instance.client;

  // Initialize the logger
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.none,
    ),
  );

  final TextEditingController namaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController tambahJumlahController = TextEditingController();

  var jumlahBarang = 0.obs;
  File? imageFile;
  String? imageUrl;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;

    if (args == null || args['shopId'] == null || args['productId'] == null) {
      Get.snackbar(
        'Error',
        'shopId atau productId tidak ditemukan. Pastikan Anda mengirim shopId dan productId saat navigasi.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      Get.back();
    } else {
      shopId = args['shopId'];
      productId = args['productId'];
      getProductData();
    }
  }

  Future<void> getProductData() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .doc(productId)
          .get();

      if (doc.exists) {
        ProductModel product =
            ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        namaController.text = product.name;
        deskripsiController.text = product.description;
        hargaController.text = product.price.toString();
        jumlahBarang.value = product.quantity;
        jumlahController.text = jumlahBarang.value.toString();
        imageUrl = product.imageUrl;
      } else {
        namaController.text = 'Produk Tidak Ditemukan';
        deskripsiController.text = '';
        hargaController.text = '0';
        jumlahBarang.value = 0;
        jumlahController.text = '0';
        imageUrl = '';
      }
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        update();
      }
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> uploadImage() async {
    if (imageFile != null) {
      try {
        final fileExt = path.extension(imageFile!.path);
        final fileName = '${productId}_${DateTime.now()}$fileExt';

        // Remove old image if exists
        if (imageUrl != null && imageUrl!.isNotEmpty) {
          // Extract file name from the URL
          Uri uri = Uri.parse(imageUrl!);
          String? oldFileName = uri.pathSegments.isNotEmpty
              ? uri.pathSegments.last
              : null;
          if (oldFileName != null) {
            try {
              await _supabase.storage.from('product_images').remove([oldFileName]);
              _logger.d("Old product image removed");
            } catch (e) {
              _logger.d("No old product image to remove or error: $e");
            }
          }
        }

        // Upload new image
        final response = await _supabase.storage
            .from('product_images')
            .upload(fileName, imageFile!);

        // Get the signed URL
        final signedUrl = await _supabase.storage
            .from('product_images')
            .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 10); // 10 years

        imageUrl = signedUrl;
        _logger.d("Product image uploaded to Supabase. URL: $imageUrl");

      } catch (e, stacktrace) {
        _logger.e("Error uploading product image to Supabase: $e",
            error: e, stackTrace: stacktrace);
        throw Exception("Failed to upload product image: $e");
      }
    }
  }

  Future<void> updateProduct() async {
    try {
      await uploadImage();
      int tambahJumlah = int.tryParse(tambahJumlahController.text) ?? 0;
      jumlahBarang.value += tambahJumlah;

      ProductModel updatedProduct = ProductModel(
        id: productId,
        name: namaController.text.trim().isNotEmpty
            ? namaController.text.trim()
            : 'Produk Tanpa Nama',
        description: deskripsiController.text.trim(),
        price: int.tryParse(hargaController.text) ?? 0,
        quantity: jumlahBarang.value,
        imageUrl: imageUrl ?? '',
      );

      await _firestore
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .doc(productId)
          .update(updatedProduct.toMap());

      // Mencatat aktivitas pengeditan produk dengan menyertakan 'transactionId: ""'
      String username = _auth.currentUser?.displayName ?? 'User';
      String email = _auth.currentUser?.email ?? 'email@example.com';

      // Membuat daftar produk detail (satu produk yang diedit)
      List<ProductDetail> productDetails = [
        ProductDetail(
          id: updatedProduct.id,
          name: updatedProduct.name,
          quantity: updatedProduct.quantity,
          price: updatedProduct.price,
        ),
      ];

      History history = History(
        id: '',
        username: username,
        email: email,
        timestamp: DateTime.now(),
        activity: 'Mengedit produk: ${updatedProduct.name}',
        transactionId: '', // Mengisi transactionId dengan string kosong
        products: productDetails, // Sertakan produk
      );

      await _historyService.addHistory(shopId, history);

      Get.snackbar('Berhasil', 'Produk berhasil diperbarui',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> deleteProduct() async {
    try {
      // Mendapatkan data produk sebelum dihapus untuk mencatat histori
      DocumentSnapshot doc = await _firestore
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .doc(productId)
          .get();

      if (doc.exists) {
        ProductModel product =
            ProductModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);

        // Remove image from Supabase if exists
        if (product.imageUrl.isNotEmpty) {
          Uri uri = Uri.parse(product.imageUrl);
          String? fileName = uri.pathSegments.isNotEmpty
              ? uri.pathSegments.last
              : null;
          if (fileName != null) {
            try {
              await _supabase.storage.from('product_images').remove([fileName]);
              _logger.d("Product image removed from Supabase");
            } catch (e) {
              _logger.d("No product image to remove or error: $e");
            }
          }
        }

        await _firestore
            .collection('shops')
            .doc(shopId)
            .collection('products')
            .doc(productId)
            .delete();

        // Mencatat aktivitas penghapusan produk dengan menyertakan 'transactionId: ""'
        String username = _auth.currentUser?.displayName ?? 'User';
        String email = _auth.currentUser?.email ?? 'email@example.com';

        List<ProductDetail> productDetails = [
          ProductDetail(
            id: product.id,
            name: product.name,
            quantity: product.quantity,
            price: product.price,
          ),
        ];

        History history = History(
          id: '',
          username: username,
          email: email,
          timestamp: DateTime.now(),
          activity: 'Menghapus produk: ${product.name}',
          transactionId: '', // Mengisi transactionId dengan string kosong
          products: productDetails, // Sertakan produk
        );

        await _historyService.addHistory(shopId, history);

        Get.back(); // Kembali ke halaman sebelumnya setelah penghapusan
        Get.snackbar('Berhasil', 'Produk berhasil dihapus',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar(
          'Error',
          'Produk tidak ditemukan.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      handleException(e);
    }
  }
}
