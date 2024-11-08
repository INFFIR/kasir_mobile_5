import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pilih_tempat_kerja_controller.dart';
import '../widgets/pilih_tempat_kerja_card.dart';

class PilihTempatKerjaPage extends StatelessWidget {
  const PilihTempatKerjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PilihTempatKerjaController controller = Get.find<PilihTempatKerjaController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PEMILIHAN TEMPAT KERJA',
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
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              if (controller.tempatKerjaList.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada tempat kerja tersedia.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.tempatKerjaList.length,
                itemBuilder: (context, index) {
                  var shopData = controller.tempatKerjaList[index];
                  return PilihTempatKerjaCard(
                    tempatKerja: shopData,
                    onTap: () {
                      Get.offAllNamed(
                        '/Home',
                        arguments: {'shopId': shopData.id},
                      );
                    },
                    onDelete: () {
                      controller.deleteTempatKerja(shopData.id);
                    },
                  );
                },
              );
            }),
          ),
          // Floating Action Button (FAB) dengan ikon '+'
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed('/Mail');
              },
              backgroundColor: const Color(0xFF28374C),
              child: const Icon(Icons.mail, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
