// controllers/tambah_produk_controller.dart
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

class TambahProdukController extends GetxController {
  late String shopId;

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

  File? imageFile;
  String? imageUrl;

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

  Future<void> uploadImage(String productId) async {
    if (imageFile != null) {
      try {
        final fileExt = path.extension(imageFile!.path);
        final fileName = '${productId}_${DateTime.now()}$fileExt';

        // Upload image to Supabase
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

  Future<void> addProduct() async {
    try {
      // Membuat productId di dalam koleksi 'products' di dalam 'shops/{shopId}'
      String productId = _firestore
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .doc()
          .id;

      await uploadImage(productId);

      ProductModel newProduct = ProductModel(
        id: productId,
        name: namaController.text.trim().isNotEmpty
            ? namaController.text.trim()
            : 'Produk Tanpa Nama',
        description: deskripsiController.text.trim(),
        price: int.tryParse(hargaController.text) ?? 0,
        quantity: int.tryParse(jumlahController.text) ?? 0,
        imageUrl: imageUrl ?? '',
      );

      await _firestore
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .doc(productId)
          .set(newProduct.toMap());

      // Mencatat aktivitas penambahan produk dengan menyertakan 'transactionId: ""'
      String username = _auth.currentUser?.displayName ?? 'User';
      String email = _auth.currentUser?.email ?? 'email@example.com';

      // Membuat daftar produk detail (satu produk yang ditambahkan)
      List<ProductDetail> productDetails = [
        ProductDetail(
          id: newProduct.id,
          name: newProduct.name,
          quantity: newProduct.quantity,
          price: newProduct.price,
        ),
      ];

      History history = History(
        id: '',
        username: username,
        email: email,
        timestamp: DateTime.now(),
        activity: 'Menambahkan produk baru: ${newProduct.name}',
        transactionId: '', // Mengisi transactionId dengan string kosong
        products: productDetails, // Sertakan produk
      );

      await _historyService.addHistory(shopId, history);

      Get.back();
      Get.snackbar('Berhasil', 'Produk berhasil ditambahkan',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      handleException(e);
    }
  }
}
