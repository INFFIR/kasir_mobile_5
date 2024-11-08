import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/pilih_toko_controller.dart';

class PilihTokoCard extends StatelessWidget {
  final DocumentSnapshot shop;

  const PilihTokoCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    // Akses controller
    final PilihTokoController controller = Get.find<PilihTokoController>();

    // Warna yang diinginkan
    const Color backgroundColor = Color(0xFFD9D9D9);
    const Color contentColor = Color(0xFF28374C);
    const BorderRadius cardBorderRadius = BorderRadius.all(Radius.circular(15.0));

    // Ukuran yang diinginkan (disesuaikan dengan ButtonSmall)
    const double cardWidth = 200.0;
    const double cardHeight = 100.0;

    return Container(
      margin: const EdgeInsets.all(10), // Menyesuaikan jarak antar kartu
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Card(
          color: backgroundColor, // Mengatur warna latar belakang Card
          shape: const RoundedRectangleBorder(
            borderRadius: cardBorderRadius, // Mengatur bentuk Card
            side: BorderSide(color: Colors.blueGrey, width: 1),
          ),
          child: InkWell(
            borderRadius: cardBorderRadius, // Memastikan efek ripple sesuai bentuk card
            onTap: () {
              Get.offAllNamed(
                '/Home',
                arguments: {'shopId': shop.id},
              );
            },
            child: Row(
              children: [
                // Leading Icon
                Container(
                  width: cardHeight, // Membuat kotak icon berukuran tinggi kartu
                  height: cardHeight,
                  decoration: const BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                  ),
                  child: const Icon(Icons.store, color: contentColor, size: 40),
                ),
                // Title and other content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      shop['name'] ?? 'Tidak ada nama toko',
                      style: const TextStyle(
                        color: contentColor,
                        fontSize: 20, // Menyesuaikan ukuran teks
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // Menangani teks panjang dengan baik
                    ),
                  ),
                ),
                // Trailing IconButton
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                  onPressed: () {
                    controller.showDeleteConfirmation(context, shop.id, shop['name']);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
