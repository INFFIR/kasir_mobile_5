import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardStorage extends StatelessWidget {
  final String itemName;
  final String itemQuantity;
  final String itemPrice;
  final String imagePath;

  const CardStorage({
    super.key,
    required this.itemName,
    required this.itemQuantity,
    required this.itemPrice,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container( // Tambahkan Container di sini untuk menambahkan margin
      margin: const EdgeInsets.all(10), // Margin 20 di setiap sisi
      child: SizedBox(
        height: 150, // Tinggi card
        width: 350, // Lebar card
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  // Gambar barang
                  Expanded(
                    flex: 3, // 30% lebar untuk gambar
                    child: Center(
                      child: Image(
                        image: AssetImage(imagePath), // Ganti dengan gambar barang
                        height: 60,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7, // 70% lebar untuk teks dan info
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Padding untuk lebih rapi
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama barang di kiri atas
                          Text(
                            itemName,
                            style: const TextStyle(
                              color: Color(0xFF28374C),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(), // Jeda untuk memposisikan jumlah di bawah
                          // Jumlah barang di kiri bawah
                          Text(
                            itemQuantity,
                            style: const TextStyle(
                              color: Color(0xFF28374C),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Icon pensil di pojok kanan atas
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    // Aksi navigasi saat ikon pensil ditekan
                    Get.toNamed('/EditProduk'); // Mengganti dengan route untuk ProfilePage
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Color(0xFF28374C),
                    size: 24,
                  ),
                ),
              ),
              // Harga di kanan bawah, di bawah icon pensil
              Positioned(
                bottom: 10,
                right: 10,
                child: Text(
                  itemPrice,
                  style: const TextStyle(
                    color: Color(0xFF28374C),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
