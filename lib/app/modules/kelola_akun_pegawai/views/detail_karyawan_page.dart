import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/widgets/bottom_nav_bar.dart';
import '../controllers/detail_karyawan_controller.dart';
import '../widgets/detail_karyawan_card.dart';

class DetailKaryawanPage extends GetView<DetailKaryawanController> {
  const DetailKaryawanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    if (args is! Map<String, dynamic>) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Data pegawai atau toko tidak tersedia.'),
        ),
      );
    }

    final String? employeeId = args['employeeId'];
    final String? shopId = args['shopId'];

    if (employeeId == null || shopId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Data pegawai atau toko tidak tersedia.'),
        ),
      );
    }

    print('DetailKaryawanPage: employeeId = $employeeId, shopId = $shopId');

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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(employeeId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || !(snapshot.data?.exists ?? false)) {
                return const Center(child: Text('Data pegawai tidak ditemukan.'));
              }

              var employeeData = snapshot.data;
              if (employeeData == null) {
                return const Center(child: Text('Data pegawai tidak ditemukan.'));
              }

              print('Employee data fetched successfully');

              return SingleChildScrollView(
                child: Center(
                  child: DetailKaryawanCard(controller: controller),
                ),
              );
            },
          ),
          Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Align(
              child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF28374C),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    'PEGAWAI ($employeeId)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
