import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/home/views/storage/edit_produk_page.dart';
import 'package:kasir_mobile_5/app/modules/home/views/storage/tambah_produk_page.dart';
import '../home_page.dart';
import '../profile/profile_page.dart';

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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Item Barang 1
                _buildItemCard(
                  context,
                  itemName: 'Nama Barang 1',
                  itemQuantity: '10 pcs',
                  itemPrice: 'Rp 100.000',
                  imagePath: 'assets/produk/barang_1.jpeg', // Ganti dengan gambar barang
                ),
                const SizedBox(height: 10), // Jarak antar card
                // Item Barang 2
                _buildItemCard(
                  context,
                  itemName: 'Nama Barang 2',
                  itemQuantity: '5 pcs',
                  itemPrice: 'Rp 75.000',
                  imagePath: 'assets/produk/barang_2.jpeg', // Ganti dengan gambar barang
                ),
                const SizedBox(height: 10), // Jarak antar card
                // Item Barang 3
                _buildItemCard(
                  context,
                  itemName: 'Nama Barang 3',
                  itemQuantity: '20 pcs',
                  itemPrice: 'Rp 200.000',
                  imagePath: 'assets/produk/barang_3.png', // Ganti dengan gambar barang
                ),
                const SizedBox(height: 10), // Jarak antar card
                // Item Barang 4
                _buildItemCard(
                  context,
                  itemName: 'Nama Barang 4',
                  itemQuantity: '15 pcs',
                  itemPrice: 'Rp 150.000',
                  imagePath: 'assets/produk/barang_4.jpeg', // Ganti dengan gambar barang
                ),
                const SizedBox(height: 10), // Jarak antar card
                // Item Barang 5
                _buildItemCard(
                  context,
                  itemName: 'Nama Barang 5',
                  itemQuantity: '8 pcs',
                  itemPrice: 'Rp 80.000',
                  imagePath: 'assets/produk/barang_5.jpg', // Ganti dengan gambar barang
                ),
                const SizedBox(height: 10), // Jarak antar card
                // Item Barang 6
                _buildItemCard(
                  context,
                  itemName: 'Nama Barang 6',
                  itemQuantity: '12 pcs',
                  itemPrice: 'Rp 120.000',
                  imagePath: 'assets/produk/barang_6.jpg', // Ganti dengan gambar barang
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TambahProdukPage()),
            );
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add),
      ),
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios_new),
            label: 'Back',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigasi ke halaman Profile
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()), // Ganti dengan nama kelas Home Anda
            );
          } else if (index == 2) {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          }
        },
      ),
    );
  }

  // Fungsi untuk membangun card barang
  Widget _buildItemCard(BuildContext context, {
    required String itemName,
    required String itemQuantity,
    required String itemPrice,
    required String imagePath,
  }) {
    return SizedBox(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProdukPage()), // Ganti dengan halaman yang diinginkan
                  );
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
    );
  }
}


