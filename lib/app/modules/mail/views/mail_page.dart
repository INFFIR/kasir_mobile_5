import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/mail_button_widget.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';
import 'terima_undangan_page.dart';
import 'mail_open_page.dart';
import 'kirim_mail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math'; // Importing dart:math for min function

class MailPage extends StatelessWidget {
  const MailPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MAIL & UNDANGAN',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          // Gambar latar belakang
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
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('mails')
                    .where('recipientId', isEqualTo: userId)
                    .snapshots(),
                builder: (context, mailSnapshot) {
                  if (mailSnapshot.hasError) {
                    return Center(child: Text('Terjadi kesalahan: ${mailSnapshot.error}'));
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('invitations')
                        .where('recipientId', isEqualTo: userId)
                        .where('status', isEqualTo: 'pending')
                        .snapshots(),
                    builder: (context, invitationSnapshot) {
                      if (invitationSnapshot.hasError) {
                        return Center(child: Text('Terjadi kesalahan: ${invitationSnapshot.error}'));
                      }

                      if (!mailSnapshot.hasData || !invitationSnapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      List<DocumentSnapshot> mails = mailSnapshot.data!.docs;
                      List<DocumentSnapshot> invitations = invitationSnapshot.data!.docs;

                      if (mails.isEmpty && invitations.isEmpty) {
                        return const Center(child: Text('Tidak ada mail atau undangan.'));
                      }

                      // Gabungkan mails dan invitations
                      List<Map<String, dynamic>> combinedList = [];

                      // Tambahkan mails
                      for (var mail in mails) {
                        combinedList.add({
                          'type': 'mail',
                          'data': mail,
                        });
                      }

                      // Tambahkan invitations
                      for (var invitation in invitations) {
                        combinedList.add({
                          'type': 'invitation',
                          'data': invitation,
                        });
                      }

                      // Urutkan berdasarkan 'createdAt' secara descending
                      combinedList.sort((a, b) {
                        Timestamp aTime = a['data']['createdAt'];
                        Timestamp bTime = b['data']['createdAt'];
                        return bTime.compareTo(aTime);
                      });

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Seksi Undangan
                            if (invitations.isNotEmpty)
                              const Text(
                                'Undangan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            const SizedBox(height: 10),
                            // List of Invitations
                            ...combinedList.where((item) => item['type'] == 'invitation').map((item) {
                              var invitation = item['data'];
                              DateTime createdAt = (invitation['createdAt'] as Timestamp).toDate();

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: MailButtonWidget(
                                  title: 'Pemilik Toko',
                                  email: '', // Anda dapat menambahkan email pemilik jika tersedia
                                  subject: 'Undangan ke toko ${invitation['shopName'] ?? ''}',
                                  date: '${createdAt.day}-${createdAt.month}-${createdAt.year}',
                                  time: '${createdAt.hour}:${createdAt.minute} WIB',
                                  description: invitation['message'] ?? '',
                                  onPressed: () {
                                    Get.to(() => TerimaUndanganPage(
                                          invitationId: invitation.id,
                                        ));
                                  },
                                ),
                              );
                            }).toList(),
                            const SizedBox(height: 20),
                            // Seksi Mail
                            if (mails.isNotEmpty)
                              const Text(
                                'Mail',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            const SizedBox(height: 10),
                            // List of Mails
                            ...combinedList.where((item) => item['type'] == 'mail').map((item) {
                              var mail = item['data'];
                              DateTime createdAt = (mail['createdAt'] as Timestamp).toDate();

                              String contentSnippet = (mail['content'] as String?) ?? '';
                              if (contentSnippet.length > 50) {
                                contentSnippet = contentSnippet.substring(0, 50);
                              }

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: MailButtonWidget(
                                  title: mail['senderName'] ?? 'Pengirim',
                                  email: mail['senderEmail'] ?? '',
                                  subject: mail['subject'] ?? 'Tanpa Subjek',
                                  date: '${createdAt.day}-${createdAt.month}-${createdAt.year}',
                                  time: '${createdAt.hour}:${createdAt.minute} WIB',
                                  description: contentSnippet,
                                  onPressed: () {
                                    Get.to(() => MailOpenPage(), arguments: {'mailId': mail.id});
                                  },
                                ),
                              );
                            }).toList(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman KirimMailPage
          Get.to(() => const KirimMailPage());
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.mail,
          color: Colors.white,
        ),
        tooltip: 'Kirim Mail',
      ),
    );
  }
}
