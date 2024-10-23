import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/bottom_nav_bar.dart';
import 'package:kasir_mobile_5/app/modules/home/widgets/button_home.dart'; // Import CustomButton

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonHome(
                    label: 'TRANSAKSI',
                    icon: Icons.attach_money,
                    routeName: '/Transaksi',
                  ),
                  ButtonHome(
                    label: 'STOK BARANG',
                    icon: Icons.inventory,
                    routeName: '/Storage',
                  ),
                  ButtonHome(
                    label: 'RIWAYAT',
                    icon: Icons.history,
                    routeName: '/AllActivity',
                  ),
                  ButtonHome(
                    label: 'KELOLA AKUN PEGAWAI',
                    icon: Icons.person_add,
                    routeName: '/KelolaAkunPegawai',
                  ),
                  SizedBox(height: 200),
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
