// MailPage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/mail_button_widget.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';
import 'terima_undangan_page.dart';
import 'mail_open_page.dart';
import 'kirim_mail_page.dart';

class MailPage extends StatelessWidget {
  const MailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration
    final List<Map<String, String>> invitations = [
      {
        'title': 'Pemilik Toko x',
        'email': 'pemilikx@example.com',
        'subject': 'Undangan Kerja Sama',
        'date': '29 - 9 2024',
        'time': '14:00 WIB',
        'description': 'Anda diundang untuk bekerja sama dalam proyek terbaru kami.',
        'body':
            'Kami mengundang Anda untuk bekerja sama dalam proyek pengembangan aplikasi terbaru kami. Silakan konfirmasi kehadiran Anda.',
      },
      // Tambahkan undangan lainnya jika diperlukan
    ];

    final List<Map<String, String>> mails = [
      {
        'title': 'Pegawai A',
        'email': 'pegawaiA@example.com',
        'subject': 'Laporan Mingguan',
        'date': '29 - 9 2024',
        'time': '14:00 WIB',
        'description': 'Berikut adalah laporan mingguan saya terkait proyek yang sedang berjalan.',
        'body':
            'Ini adalah laporan mingguan dari Pegawai A mengenai progres proyek.',
      },
      {
        'title': 'Pegawai B',
        'email': 'pegawaiB@example.com',
        'subject': 'Permintaan Cuti',
        'date': '29 - 9 2024',
        'time': '14:05 WIB',
        'description': 'Saya mengajukan permintaan cuti untuk keperluan pribadi.',
        'body':
            'Pegawai B mengajukan permintaan cuti selama dua minggu.',
      },
      {
        'title': 'Pegawai C',
        'email': 'pegawaiC@example.com',
        'subject': 'Feedback Proyek',
        'date': '29 - 9 2024',
        'time': '14:10 WIB',
        'description': 'Berikut adalah feedback saya terhadap proyek terbaru.',
        'body':
            'Pegawai C memberikan feedback positif terhadap proyek terbaru.',
      },
      {
        'title': 'Pegawai D',
        'email': 'pegawaiD@example.com',
        'subject': 'Permintaan Alat',
        'date': '29 - 9 2024',
        'time': '14:15 WIB',
        'description': 'Saya membutuhkan tambahan alat untuk menunjang pekerjaan.',
        'body':
            'Pegawai D meminta tambahan alat seperti laptop baru untuk meningkatkan produktivitas.',
      },
      {
        'title': 'Pegawai E',
        'email': 'pegawaiE@example.com',
        'subject': 'Update Database',
        'date': '29 - 9 2024',
        'time': '14:20 WIB',
        'description': 'Database telah diperbarui sesuai kebutuhan proyek.',
        'body':
            'Pegawai E telah melakukan update pada database proyek terbaru.',
      },
      // Tambahkan mail lainnya jika diperlukan
    ];

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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Seksi Undangan
                    const Text(
                      'Undangan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // List of Invitations
                    ...invitations.map((invitation) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: MailButtonWidget(
                          title: invitation['title']!,
                          email: invitation['email']!,
                          subject: invitation['subject']!,
                          date: invitation['date']!,
                          time: invitation['time']!,
                          description: invitation['description']!,
                          onPressed: () {
                            Get.to(() => TerimaUndanganPage(
                                  username: invitation['title']!,
                                  email: invitation['email']!,
                                  subject: invitation['subject']!,
                                  date: invitation['date']!,
                                  time: invitation['time']!,
                                  body: invitation['body']!,
                                ));
                          },
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),

                    // Seksi Mail
                    const Text(
                      'Mail',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // List of Mails
                    ...mails.map((mail) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: MailButtonWidget(
                          title: mail['title']!,
                          email: mail['email']!,
                          subject: mail['subject']!,
                          date: mail['date']!,
                          time: mail['time']!,
                          description: mail['description']!,
                          onPressed: () {
                            Get.to(() => MailOpenPage(
                                  username: mail['title']!,
                                  email: mail['email']!,
                                  subject: mail['subject']!,
                                  date: mail['date']!,
                                  time: mail['time']!,
                                  body: mail['body']!,
                                ));
                          },
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                  ],
                ),
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
        child: const Icon(Icons.mail, color: Colors.white,),
        tooltip: 'Kirim Mail',
      ),
    );
  }
}
