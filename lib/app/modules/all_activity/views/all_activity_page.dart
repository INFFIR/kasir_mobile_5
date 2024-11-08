// views/all_activity_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/widgets/bottom_nav_bar.dart';
import '../models/history_model.dart';
import '../services/history_service.dart';

class AllActivityPage extends StatelessWidget {
  final HistoryService _historyService = HistoryService();

  // Asumsikan Anda menerima shopId sebagai argumen
  final String shopId = Get.arguments['shopId'];

  AllActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('ALL ACTIVITY'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.png', // Ganti dengan path gambar Anda
              fit: BoxFit.cover, // Agar gambar menutupi seluruh halaman
            ),
          ),
          // Container untuk konten
          Positioned(
            top: 10, // Jarak dari atas
            left: 10, // Jarak dari kiri
            right: 10, // Jarak dari kanan
            bottom: 10, // Jarak dari bawah
            child: Container(
              width: double.infinity, // Mengisi lebar penuh dari posisi
              height: double.infinity, // Mengisi tinggi penuh dari posisi
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), // Latar belakang putih dengan sedikit transparansi
                borderRadius: BorderRadius.circular(12), // Sudut membulat
              ),
              child: StreamBuilder<List<History>>(
                stream: _historyService.getHistories(shopId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Tidak ada aktivitas.'));
                  } else {
                    List<History> histories = snapshot.data!;
                    return ListView.builder(
                      itemCount: histories.length,
                      itemBuilder: (context, index) {
                        History history = histories[index];
                        return ElevatedButton(
                          onPressed: () {
                            // Jika aktivitas adalah transaksi, arahkan ke StrukPage
                            if (history.activity.contains('pembayaran')) {
                              String transactionId = history.transactionId; // Menggunakan transactionId langsung
                              if (transactionId.isNotEmpty) {
                                Get.toNamed('/Struk', arguments: {
                                  'shopId': shopId,
                                  'transactionId': transactionId,
                                });
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Baris atas: Username & Email di kiri, Waktu & Tanggal di kanan
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Username dan Email
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        history.username,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        history.email,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Waktu dan Tanggal
                                  Text(
                                    '${history.timestamp.day}-${history.timestamp.month}-${history.timestamp.year} ${history.timestamp.hour}:${history.timestamp.minute} WIB',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Informasi Aktivitas
                              Text(
                                history.activity,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
