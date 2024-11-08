// views/all_activity_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/widgets/bottom_nav_bar.dart';
import '../models/history_model.dart';
import '../services/history_service.dart';
import '../widgets/activity_button_widget.dart';

class AllActivityPage extends StatelessWidget {
  final HistoryService _historyService = HistoryService();

  // Asumsikan Anda menerima shopId sebagai argumen
  final String shopId = Get.arguments['shopId'];

  AllActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ALL ACTIVITY',
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
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: histories.map((history) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: ActivityButtonWidget(
                              username: history.username,
                              email: history.email,
                              date:
                                  '${history.timestamp.day}-${history.timestamp.month}-${history.timestamp.year}',
                              time:
                                  '${history.timestamp.hour}:${history.timestamp.minute} WIB',
                              activity: history.activity,
                              onPressed: () {
                                if (history.activity.contains('pembayaran')) {
                                  String transactionId = history.transactionId;
                                  if (transactionId.isNotEmpty) {
                                    Get.toNamed('/Struk', arguments: {
                                      'shopId': shopId,
                                      'transactionId': transactionId,
                                    });
                                  }
                                }
                              },
                            ),
                          );
                        }).toList(),
                      ),
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
