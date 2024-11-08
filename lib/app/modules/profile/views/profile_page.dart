// lib/modules/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/widgets/bottom_nav_bar.dart';
import '../../components/widgets/button_small.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

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
          SingleChildScrollView(
            child: Center(
              child: Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileController.profilePictureUrl.value.isNotEmpty
                          ? NetworkImage(_profileController.profilePictureUrl.value)
                          : const AssetImage('assets/default.png') as ImageProvider,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _profileController.username.value,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Color(0xFF28374C),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _profileController.bio.value.isNotEmpty
                          ? _profileController.bio.value
                          : 'Tidak ada bio.',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFF28374C),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ButtonSmall(
                      icon: Icons.edit,
                      label: 'EDIT PROFILE',
                      onPressed: () {
                        Get.toNamed('/ChangeProfile');
                      },
                    ),
                    ButtonSmall(
                      icon: Icons.lock,
                      label: 'GANTI PASSWORD',
                      onPressed: () {
                        Get.toNamed('/ChangePassword');
                      },
                    ),
                    ButtonSmall(
                      icon: Icons.history,
                      label: 'AKTIVITAS ANDA',
                      onPressed: () {
                        Get.toNamed('/ActivityProfile');
                      },
                    ),
                    ButtonSmall(
                      icon: Icons.logout,
                      label: 'LOG OUT',
                      buttonColor: Colors.red,
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.offAllNamed('/Login');
                      },
                    ),
                    const SizedBox(height: 200),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
