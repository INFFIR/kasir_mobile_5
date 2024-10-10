import 'package:flutter/material.dart';

class EditItemPage extends StatelessWidget {
  const EditItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'EDIT ITEM',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: Colors.white,
            onPressed: () {
              // Aksi untuk menyimpan item
            },
          ),
        ],
      ),
      body: Stack( // Use Stack to layer the background image and content
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // Ganti dengan path gambar Anda
                fit: BoxFit.cover, // Mengatur agar gambar menutupi seluruh halaman
              ),
            ),
          ),
          SingleChildScrollView( // This will prevent overflow
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8), // Make the box slightly transparent
                    borderRadius: BorderRadius.circular(10), // Radius sudut
                  ),
                  padding: const EdgeInsets.all(20), // Padding di dalam kotak
                  margin: const EdgeInsets.all(20), // Memberikan margin 10 di setiap sudut
                  child: Column(
                    children: [
                      // Stack untuk menempatkan gambar dan ikon pensil
                      Stack(
                        alignment: Alignment.topRight, // Menempatkan ikon pensil di kanan atas
                        children: [
                          Center( // Menggunakan Center untuk memusatkan gambar
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/background.png'), // Ganti dengan path gambar kamu
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10), // Radius sudut agar terlihat rapi
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0), // Menggeser 10 pixel ke atas dan 10 pixel ke kiri
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Aksi saat ikon pensil ditekan
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Nama Barang',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Harga',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Jumlah Barang',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Tombol + dan -
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              // Aksi untuk mengurangi jumlah
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              // Aksi untuk menambah jumlah
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: () {
                          // Aksi saat tombol hapus produk ditekan
                        },
                        child: const Text("Hapus Produk"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
            // Aksi untuk profile
          }
        },
      ),
    );
  }
}
