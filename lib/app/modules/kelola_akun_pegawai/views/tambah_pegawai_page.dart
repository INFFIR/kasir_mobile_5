import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';

class TambahPegawaiPage extends StatefulWidget {
  const TambahPegawaiPage({super.key});

  @override
  _TambahPegawaiPageState createState() => _TambahPegawaiPageState();
}

class _TambahPegawaiPageState extends State<TambahPegawaiPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendInvitation() async {
    String email = _emailController.text.trim();
    String message = _messageController.text.trim();
    String shopId = Get.arguments['shopId'];

    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email tidak boleh kosong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Cari user berdasarkan email
      QuerySnapshot userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userSnapshot.docs.isEmpty) {
        Get.snackbar(
          'Error',
          'User dengan email tersebut tidak ditemukan',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return;
      }

      String recipientId = userSnapshot.docs.first.id;
      String senderId = _auth.currentUser!.uid;

      // Ambil nama toko
      DocumentSnapshot shopSnapshot =
          await _firestore.collection('shops').doc(shopId).get();
      String shopName = shopSnapshot['name'] ?? 'Toko';

      // Kirim undangan
      await _firestore.collection('invitations').add({
        'senderId': senderId,
        'recipientId': recipientId,
        'shopId': shopId,
        'shopName': shopName,
        'message': message,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Menampilkan pop-up dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Berhasil'),
            content: const Text('Undangan telah dikirimkan!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                  Get.back();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengirim undangan: $e',
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
        title: const Text('UNDANG PEGAWAI'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email :',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Pesan (Optional) :',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendInvitation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Undang Pegawai'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
