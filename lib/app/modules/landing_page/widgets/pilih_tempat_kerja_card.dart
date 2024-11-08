// widgets/pilih_tempat_kerja_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/pilih_tempat_kerja_controller.dart';

class PilihTempatKerjaCard extends StatelessWidget {
  final DocumentSnapshot tempatKerja;

  const PilihTempatKerjaCard({super.key, required this.tempatKerja});

  @override
  Widget build(BuildContext context) {
    // Akses controller
    final PilihTempatKerjaController controller = Get.find<PilihTempatKerjaController>();

    // Warna yang diinginkan
    const Color backgroundColor = Color(0xFFD9D9D9);
    const Color contentColor = Color(0xFF28374C);
    const BorderRadius cardBorderRadius = BorderRadius.all(Radius.circular(15.0));

    // Ukuran yang diinginkan
    const double cardHeight = 100.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
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
              // Aksi saat kartu ditekan, misalnya navigasi ke detail tempat kerja
              Get.toNamed(
                '/Home',
                arguments: {'tempatKerjaId': tempatKerja.id},
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
                  child: const Icon(Icons.location_city, color: contentColor, size: 40),
                ),
                // Title and other content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tempatKerja['name'] ?? 'Tidak ada nama',
                          style: const TextStyle(
                            color: contentColor,
                            fontSize: 20, // Menyesuaikan ukuran teks
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis, // Menangani teks panjang dengan baik
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tempatKerja['address'] ?? 'Tidak ada alamat',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                // Trailing IconButton
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                  onPressed: () {
                    controller.showDeleteConfirmation(context, tempatKerja.id, tempatKerja['name'] ?? 'Tidak ada nama');
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
