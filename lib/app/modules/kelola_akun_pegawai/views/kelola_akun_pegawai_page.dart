import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/widgets/bottom_nav_bar.dart';
import '../widgets/kelola_akun_pegawai_card.dart'; // Menggunakan card terpisah

class KelolaAkunPegawaiPage extends StatelessWidget {
  const KelolaAkunPegawaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    String shopId = Get.arguments['shopId']; // Dapatkan shopId dari arguments

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'KELOLA AKUN PEGAWAI',
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
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('employee_shops')
                .where('shopId', isEqualTo: shopId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('Belum ada pegawai.'));
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var employeeData = snapshot.data!.docs[index];
                  return KelolaAkunPegawaiCard(
                    employeeData: employeeData,
                    onTap: () {
                      Get.toNamed('/DetailKaryawan', arguments: {
                        'employeeId': employeeData['userId'],
                        'shopId': shopId,
                      });
                    },
                  );
                },
              );
            },
          ),
          // Floating Action Button (FAB) dengan ikon '+'
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed('/TambahPegawai', arguments: {'shopId': shopId});
              },
              backgroundColor: const Color(0xFF28374C),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
