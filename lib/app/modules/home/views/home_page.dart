import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/widgets/bottom_nav_bar.dart';
import '../controllers/home_controller.dart';
import '../../components/widgets/button_medium.dart'; // Import ButtonMedium

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'HALAMAN UTAMA',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.email),
            color: Colors.white,
            onPressed: () {
              Get.toNamed('/Mail');
            },
          ),
        ],
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
          // Content
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonMedium(
                    label: 'TRANSAKSI',
                    icon: Icons.attach_money,
                    routeName: '/Transaksi',
                    arguments: {'shopId': controller.shopId},
                  ),
                  ButtonMedium(
                    label: 'STOK BARANG',
                    icon: Icons.inventory,
                    routeName: '/Storage',
                    arguments: {'shopId': controller.shopId},
                  ),
                  ButtonMedium(
                    label: 'RIWAYAT',
                    icon: Icons.history,
                    routeName: '/AllActivity',
                    arguments: {'shopId': controller.shopId},
                  ),
                  ButtonMedium(
                    label: 'KELOLA AKUN PEGAWAI',
                    icon: Icons.person_add,
                    routeName: '/KelolaAkunPegawai',
                    arguments: {'shopId': controller.shopId},
                  ),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
