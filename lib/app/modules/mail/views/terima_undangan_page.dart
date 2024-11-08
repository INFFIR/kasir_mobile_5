import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';
import 'package:get/get.dart';
import 'kirim_mail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TerimaUndanganPage extends StatelessWidget {
  final String invitationId;

  const TerimaUndanganPage({
    super.key,
    required this.invitationId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('invitations').doc(invitationId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Terima Undangan'),
              backgroundColor: Colors.blueGrey,
            ),
            body: Center(child: Text('Terjadi kesalahan: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Terima Undangan'),
              backgroundColor: Colors.blueGrey,
            ),
            body: const Center(child: Text('Undangan tidak ditemukan.')),
          );
        }
        var invitationData = snapshot.data!;
        String senderId = invitationData['senderId'] ?? '';
        String shopId = invitationData['shopId'] ?? '';
        String shopName = invitationData['shopName'] ?? 'Toko';
        String message = invitationData['message'] ?? '';
        DateTime createdAt = (invitationData['createdAt'] as Timestamp).toDate();

        // Mendapatkan lebar layar
        final screenWidth = MediaQuery.of(context).size.width;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Terima Undangan'),
            backgroundColor: Colors.blueGrey,
          ),
          body: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/background.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Container untuk konten
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                bottom: 10,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Kotak untuk konten
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(16.0),
                          width: screenWidth - 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F2FA),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Undangan
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left Side: Username and Email
                                  FutureBuilder<DocumentSnapshot>(
                                    future: FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(senderId)
                                        .get(),
                                    builder: (context, senderSnapshot) {
                                      if (senderSnapshot.hasData && senderSnapshot.data!.exists) {
                                        var senderData = senderSnapshot.data!;
                                        String senderName = senderData['username'] ?? 'Pemilik Toko';
                                        String senderEmail = senderData['email'] ?? '';
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              senderName,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              senderEmail,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Pemilik Toko',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                  // Right Side: Date and Time
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${createdAt.day}-${createdAt.month}-${createdAt.year}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '${createdAt.hour}:${createdAt.minute} WIB',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Subject
                              Text(
                                'Undangan ke toko $shopName',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              // Body
                              Text(
                                message,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Tombol Terima dan Tolak
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Logika untuk menerima undangan
                                      String userId = FirebaseAuth.instance.currentUser!.uid;
                                      // Terima undangan
                                      await FirebaseFirestore.instance
                                          .collection('employee_shops')
                                          .doc(userId + '_' + shopId)
                                          .set({
                                        'userId': userId,
                                        'shopId': shopId,
                                        'joinedAt': FieldValue.serverTimestamp(),
                                      });
                                      // Update status undangan
                                      await FirebaseFirestore.instance
                                          .collection('invitations')
                                          .doc(invitationId)
                                          .update({'status': 'accepted'});

                                      Get.snackbar(
                                        'Berhasil',
                                        'Anda telah menerima undangan.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white,
                                      );
                                      // Navigasi ke halaman kerja
                                      Get.offAllNamed('/PilihTempatKerja');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Terima'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // Logika untuk menolak undangan
                                      await FirebaseFirestore.instance
                                          .collection('invitations')
                                          .doc(invitationId)
                                          .update({'status': 'declined'});

                                      Get.snackbar(
                                        'Dibatalkan',
                                        'Anda telah menolak undangan.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Tolak'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        );
      },
    );
  }
}
