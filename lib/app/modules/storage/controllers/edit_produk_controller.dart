import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../utils/storage_exception_handler.dart';

class EditProdukController extends GetxController {
  late String shopId;
  late String productId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        String fileName = '${productId}_${DateTime.now()}';
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('product_images')
            .child(fileName);
        await ref.putFile(imageFile!);
        imageUrl = await ref.getDownloadURL();
      } catch (e) {
        handleException(e);
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

      Get.snackbar('Berhasil', 'Produk berhasil diperbarui',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> deleteProduct() async {
    try {
      await _firestore
          .collection('shops')
          .doc(shopId)
          .collection('products')
          .doc(productId)
          .delete();

      Get.back(); // Kembali ke halaman sebelumnya setelah penghapusan
      Get.snackbar('Berhasil', 'Produk berhasil dihapus',
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      handleException(e);
    }
  }
}
