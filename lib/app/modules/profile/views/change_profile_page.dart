// lib/pages/change_profile_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../components/widgets/bottom_nav_bar.dart';
import '../controllers/profile_controller.dart';

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({super.key});

  @override
  _ChangeProfilePageState createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  final ProfileController _profileController = Get.find<ProfileController>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _usernameController.text = _profileController.username.value;
    _bioController.text = _profileController.bio.value;

    // Listen to changes in the controller to update the UI
    ever(_profileController.username, (value) {
      _usernameController.text = value;
    });
    ever(_profileController.bio, (value) {
      _bioController.text = value;
    });
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      // Handle the exception by showing a dialog or a snackbar
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to pick image: $e'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _changeProfile() async {
    String username = _usernameController.text.trim();
    String bio = _bioController.text.trim();

    if (username.isEmpty) {
      Get.dialog(
        AlertDialog(
          title: const Text("Input Kosong"),
          content: const Text("Username tidak boleh kosong."),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    try {
      await _profileController.updateProfile(
        username: username,
        bio: bio,
        profileImage: _selectedImage,
      );

      Get.dialog(
        AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Profile berhasil diubah!'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text('Terjadi kesalahan: $e'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UBAH PROFILE'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 350,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Obx(() {
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : (_profileController.profilePictureUrl.value.isNotEmpty
                                    ? NetworkImage(_profileController.profilePictureUrl.value)
                                    : const AssetImage('assets/default.png') as ImageProvider),
                          );
                        }),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tap to change profile picture',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan Username:',
                          filled: true,
                          fillColor: Colors.grey.shade200.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _bioController,
                        decoration: InputDecoration(
                          labelText: 'Bio (Optional):',
                          filled: true,
                          fillColor: Colors.grey.shade200.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        obscureText: false,
                      ),
                      const SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: _changeProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Ubah Profile'),
                      ),
                    ],
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
