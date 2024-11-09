// lib/controllers/profile_controller.dart
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

class ProfileController extends GetxController {
  var username = ''.obs;
  var bio = ''.obs;
  var email = ''.obs;
  var profilePictureUrl = ''.obs;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final supabase.SupabaseClient _supabase = supabase.Supabase.instance.client;

  // Initialize the logger
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.none,
    ),
  );

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    auth.User? user = _auth.currentUser;
    if (user != null) {
      _logger.d("Fetching user profile for UID: ${user.uid}");
      try {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          Map<String, dynamic>? data =
              userDoc.data() as Map<String, dynamic>?;
          _logger.d("Data user: $data");

          // Tetapkan nilai default jika data null atau kosong
          username.value =
              data?['username']?.isNotEmpty == true ? data!['username'] : 'Anonymous';
          bio.value =
              data?['bio']?.isNotEmpty == true ? data!['bio'] : 'Tidak ada bio.';
          email.value =
              data?['email']?.isNotEmpty == true ? data!['email'] : 'No email';
          profilePictureUrl.value = data?['profilePicture']?.isNotEmpty == true
              ? data!['profilePicture']
              : '';
        } else {
          _logger.w("Dokumen pengguna tidak ditemukan di Firestore.");
          setDefaultValues();
        }
      } catch (e, stacktrace) {
        _logger.e("Error fetching user profile: $e", error: e, stackTrace: stacktrace);
        setDefaultValues();
      }
    } else {
      _logger.w("Tidak ada user yang sedang login.");
      setDefaultValues();
    }
  }

  // Fungsi untuk menetapkan nilai default jika data kosong atau error
  void setDefaultValues() {
    username.value = 'Anonymous';
    bio.value = 'Tidak ada bio.';
    email.value = 'No email';
    profilePictureUrl.value = '';
  }

  Future<void> updateProfile({String? username, String? bio, File? profileImage}) async {
    auth.User? user = _auth.currentUser;
    if (user != null) {
      Map<String, dynamic> dataToUpdate = {};
      if (username != null) dataToUpdate['username'] = username;
      dataToUpdate['bio'] = bio ?? '';

      if (profileImage != null) {
        try {
          final fileExt = path.extension(profileImage.path);
          final fileName = '${user.uid}$fileExt';

          try {
            await _supabase.storage.from('avatars').remove([fileName]);
            _logger.d("Old profile picture removed");
          } catch (e) {
            _logger.d("No old profile picture to remove or error: $e");
          }

          final response = await _supabase.storage
              .from('kasir_mobile')
              .upload(fileName, profileImage);

          final imageUrl = await _supabase.storage
              .from('kasir_mobile')
              .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 10);

          dataToUpdate['profilePicture'] = imageUrl;
          _logger.d("Profile picture uploaded to Supabase. URL: $imageUrl");

        } catch (e, stacktrace) {
          _logger.e("Error uploading profile picture to Supabase: $e",
              error: e, stackTrace: stacktrace);
          throw Exception("Failed to upload profile picture: $e");
        }
      }

      if (dataToUpdate.isNotEmpty) {
        try {
          DocumentReference userDocRef =
              _firestore.collection('users').doc(user.uid);
          DocumentSnapshot userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update(dataToUpdate); // Update jika dokumen ada
            _logger.i("User profile updated for UID: ${user.uid}"); // Info
          } else {
            await userDocRef.set(dataToUpdate); // Buat dokumen baru jika tidak ada
            _logger.i("User profile created for UID: ${user.uid}"); // Info
          }
          await fetchUserProfile(); // Refresh data
        } catch (e, stacktrace) {
          _logger.e("Error updating profile: $e", error: e, stackTrace: stacktrace);
          setDefaultValues();
        }
      }
    } else {
      _logger.w("Tidak ada user yang sedang login untuk mengupdate profil.");
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    auth.User? user = _auth.currentUser;
    if (user != null) {
      auth.AuthCredential credential = auth.EmailAuthProvider.credential(
          email: user.email!, password: oldPassword);
      try {
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        _logger.i("Password updated successfully for UID: ${user.uid}"); // Info
      } catch (e, stacktrace) {
        _logger.e("Error changing password: $e", error: e, stackTrace: stacktrace);
        rethrow; // Re-throw the caught exception to preserve stack trace
      }
    }
  }
}
