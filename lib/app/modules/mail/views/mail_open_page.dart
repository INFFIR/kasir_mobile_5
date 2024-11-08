// MailOpenPage.dart
import 'package:flutter/material.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';
import 'package:get/get.dart';
import 'kirim_mail_page.dart';

class MailOpenPage extends StatelessWidget {
  final String username;
  final String email;
  final String subject;
  final String date;
  final String time;
  final String body;

  const MailOpenPage({
    Key? key,
    this.username = 'Pegawai n',
    this.email = 'pegawai@example.com',
    this.subject = 'Subjek Email',
    this.date = '29 - 9 2024',
    this.time = '14:00 WIB',
    this.body = """
Ini adalah isi dari email. Anda dapat menulis apa saja di sini sesuai dengan kebutuhan aplikasi Anda.
""",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar layar
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MAIL'),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: true,
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
                          // Header Email
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Side: Username and Email
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    username,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    email,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              // Right Side: Date and Time
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    time,
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
                            subject,
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
                            body,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
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
      // Floating Action Button untuk Balas Pesan
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke KirimMailPage dengan pre-filled recipient dan subject
          Get.to(() => KirimMailPage(
                initialRecipient: email,
                initialSubject: 'Re: $subject',
              ));
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.reply),
        tooltip: 'Balas Pesan',
      ),
    );
  }
}
