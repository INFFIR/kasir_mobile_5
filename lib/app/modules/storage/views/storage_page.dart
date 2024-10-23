import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/bottom_nav_bar.dart';
import 'package:kasir_mobile_5/app/modules/storage/widgets/card_storage.dart'; // Tambahkan ini

class StoragePage extends StatelessWidget {
  const StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Storage',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // Ganti dengan path gambar Anda
            fit: BoxFit.cover, // Mengatur agar gambar menutupi seluruh halaman
          ),
        ),
        child: const SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Item Barang 1
                CardStorage(
                  itemName: 'Nama Barang 1',
                  itemQuantity: '10 pcs',
                  itemPrice: 'Rp 100.000',
                  imagePath: 'assets/produk/barang_1.jpeg', // Ganti dengan gambar barang
                ),
                // Item Barang 2
                CardStorage(
                  itemName: 'Nama Barang 2',
                  itemQuantity: '5 pcs',
                  itemPrice: 'Rp 75.000',
                  imagePath: 'assets/produk/barang_2.jpeg', // Ganti dengan gambar barang
                ),
                // Item Barang 3
                CardStorage(
                  itemName: 'Nama Barang 3',
                  itemQuantity: '20 pcs',
                  itemPrice: 'Rp 200.000',
                  imagePath: 'assets/produk/barang_3.png', // Ganti dengan gambar barang
                ),
                // Item Barang 4
                CardStorage(
                  itemName: 'Nama Barang 4',
                  itemQuantity: '15 pcs',
                  itemPrice: 'Rp 150.000',
                  imagePath: 'assets/produk/barang_4.jpeg', // Ganti dengan gambar barang
                ),
                // Item Barang 5
                CardStorage(
                  itemName: 'Nama Barang 5',
                  itemQuantity: '8 pcs',
                  itemPrice: 'Rp 80.000',
                  imagePath: 'assets/produk/barang_5.jpg', // Ganti dengan gambar barang
                ),
                // Item Barang 6
                CardStorage(
                  itemName: 'Nama Barang 6',
                  itemQuantity: '12 pcs',
                  itemPrice: 'Rp 120.000',
                  imagePath: 'assets/produk/barang_6.jpg', // Ganti dengan gambar barang
                ),
                SizedBox(height: 200), // Jarak antar card
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Get.toNamed('/TambahProduk'); // Mengganti dengan route untuk ProfilePage
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, color: Colors.white,),
        
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
