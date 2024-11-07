import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PilihTokoPage extends StatefulWidget {
  const PilihTokoPage({super.key});

  @override
  _PilihTokoPageState createState() => _PilihTokoPageState();
}

class _PilihTokoPageState extends State<PilihTokoPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> _getShops() {
    String userId = _auth.currentUser!.uid;
    return _firestore
        .collection('shops')
        .where('ownerId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  void _konfirmasiHapusToko(
      BuildContext context, String shopId, String shopName) {
    final TextEditingController confirmationController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Penghapusan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Ketikkan ulang nama toko untuk mengonfirmasi penghapusan:'),
              const SizedBox(height: 10),
              TextField(
                controller: confirmationController,
                decoration: const InputDecoration(
                  labelText: 'Nama Toko',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                String inputName = confirmationController.text.trim();
                if (inputName == shopName) {
                  _hapusToko(shopId);
                  Navigator.of(context)
                      .pop(); // Menutup dialog setelah penghapusan
                } else {
                  Get.snackbar(
                    'Error',
                    'Nama toko tidak cocok',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _hapusToko(String shopId) async {
    try {
      await _firestore.collection('shops').doc(shopId).delete();
      if (!mounted) return; // Memeriksa apakah widget masih terpasang
      Get.snackbar(
        'Berhasil',
        'Toko dihapus',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      if (!mounted) return; // Memeriksa apakah widget masih terpasang
      Get.snackbar(
        'Error',
        'Gagal menghapus toko: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                image: AssetImage('assets/background.png'), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _getShops(),
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
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side:
                          const BorderSide(color: Colors.blueGrey, width: 1),
                    ),
                    child: ListTile(
                      leading:
                          const Icon(Icons.store, color: Color(0xFF28374C)),
                      title: Text(
                        shop['name'] ?? 'Tidak ada nama toko',
                        style: const TextStyle(
                          color: Color(0xFF28374C),
                          fontSize: 20,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _konfirmasiHapusToko(context, shop.id, shop['name']);
                        },
                      ),
                      onTap: () {
                        Get.offAllNamed(
                          '/Home',
                          arguments: {'shopId': shop.id},
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
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
