import 'package:flutter/material.dart';
import '../profile/profile_page.dart';
import '../homepage/home_page.dart';

void main() {
  runApp(const MaterialApp(
    home: TransaksiPage(),
  ));
}

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  // List untuk menyimpan jumlah pembelian sebagai string
  List<String> jumlahPembelianList = List.filled(6, '0'); // Menginisialisasi dengan 6 item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'EDIT PRODUK',
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 50),
                _buildItemCard(
                  index: 0,
                  nama_produk: 'BARANG 1',
                  deksripsi_produk: 'Deskripsi barang 1',
                  jumlahStok: '1000 Pcs',
                  harga_produk: 'Rp20.000',
                  imagePath: 'assets/produk/barang_1.jpeg',
                ),
                const SizedBox(height: 10),
                _buildItemCard(
                  index: 1,
                  nama_produk: 'BARANG 2',
                  deksripsi_produk: 'Deskripsi barang 2',
                  jumlahStok: '1000 Pcs',
                  harga_produk: 'Rp20.000',
                  imagePath: 'assets/produk/barang_2.jpeg',
                ),
                const SizedBox(height: 10),
                _buildItemCard(
                  index: 2,
                  nama_produk: 'BARANG 3',
                  deksripsi_produk: 'Deskripsi barang 3',
                  jumlahStok: '1000 Pcs',
                  harga_produk: 'Rp20.000',
                  imagePath: 'assets/produk/barang_3.png',
                ),
                const SizedBox(height: 10),
                _buildItemCard(
                  index: 3,
                  nama_produk: 'BARANG 4',
                  deksripsi_produk: 'Deskripsi barang 4',
                  jumlahStok: '1000 Pcs',
                  harga_produk: 'Rp20.000',
                  imagePath: 'assets/produk/barang_4.jpeg',
                ),
                const SizedBox(height: 10),
                _buildItemCard(
                  index: 4,
                  nama_produk: 'BARANG 5',
                  deksripsi_produk: 'Deskripsi barang 5',
                  jumlahStok: '1000 Pcs',
                  harga_produk: 'Rp20.000',
                  imagePath: 'assets/produk/barang_5.jpg',
                ),
                const SizedBox(height: 10),
                _buildItemCard(
                  index: 5,
                  nama_produk: 'BARANG 6',
                  deksripsi_produk: 'Deskripsi barang 6',
                  jumlahStok: '1000 Pcs',
                  harga_produk: 'Rp20.000',
                  imagePath: 'assets/produk/barang_6.jpg',
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
          Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Align(
              child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF28374C).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari...',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Tambahkan fungsionalitas pencarian di sini
                      },
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (index == 2) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget _buildItemCard({
    required int index,
    required String nama_produk,
    required String deksripsi_produk,
    required String jumlahStok,
    required String harga_produk,
    required String imagePath,
  }) {
    // Controller untuk input jumlah barang
    final TextEditingController _jumlahPembelianController =
        TextEditingController(text: jumlahPembelianList[index]);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0), // Atur radius card di sini
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Gambar produk
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // Atur radius gambar di sini
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Informasi produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama barang di kiri atas
                  Text(
                    nama_produk,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Deskripsi barang di tengah
                  Text(
                    deksripsi_produk,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  // Jumlah stok di kiri bawah
                  Text(jumlahStok),
                ],
              ),
            ),
            // Kolom untuk harga dan ikon plus/minus
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Harga di kanan atas
                Text(
                  harga_produk,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Tombol pengurangan dan penambahan jumlah barang
                Row(
                  children: [
                    // Tombol pengurangan jumlah barang di kiri
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          // Mengurangi jumlah barang
                          int currentJumlah = int.parse(jumlahPembelianList[index]);
                          if (currentJumlah > 0) {
                            currentJumlah--;
                            jumlahPembelianList[index] = currentJumlah.toString();
                          }
                          _jumlahPembelianController.text = jumlahPembelianList[index]; // Update nilai pada controller
                        });
                      },
                    ),
                    // TextField untuk input jumlah barang
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: TextField(
                        controller: _jumlahPembelianController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            jumlahPembelianList[index] = value; // Update nilai pada list
                          });
                        },
                      ),
                    ),
                    // Tombol penambahan jumlah barang di kanan
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          // Menambah jumlah barang
                          int currentJumlah = int.parse(jumlahPembelianList[index]);
                          currentJumlah++;
                          jumlahPembelianList[index] = currentJumlah.toString();
                          _jumlahPembelianController.text = jumlahPembelianList[index]; // Update nilai pada controller
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
