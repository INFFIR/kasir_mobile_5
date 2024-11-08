import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/pilih_toko_controller.dart';
import '../widgets/pilih_toko_card.dart';

class PilihTokoPage extends StatelessWidget {
  const PilihTokoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the binding is applied
    // This is usually handled in your route definitions
    // If not, you can apply it here using:
    // PilihTokoBinding().dependencies();

    // Access the controller
    final PilihTokoController controller = Get.find<PilihTokoController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PILIH TOKO',
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
                image: AssetImage('assets/background.png'), // Ensure this asset exists
                fit: BoxFit.cover,
              ),
            ),
          ),
          // StreamBuilder to listen to shops data
          StreamBuilder<QuerySnapshot>(
            stream: controller.shops,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final shops = snapshot.data!.docs;
              if (shops.isEmpty) {
                return const Center(child: Text('Anda belum memiliki toko.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  var shop = shops[index];
                  return PilihTokoCard(shop: shop);
                },
              );
            },
          ),
          // Floating Action Button to add a new shop
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed('/BuatToko');
              },
              backgroundColor: const Color(0xFF28374C),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
