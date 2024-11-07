// lib/controllers/profile_controller.dart
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:logger/logger.dart'; // Import the logger package

class ProfileController extends GetxController {
  var username = ''.obs;
  var bio = ''.obs;
  var email = ''.obs;
  var profilePictureUrl = ''.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Initialize the logger
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // No method calls in the log
      errorMethodCount: 5, // Show 5 method calls if there's an error
      lineLength: 50, // Width of the log
      colors: true, // Colorful log messages
      printEmojis: true, // Print emojis
      dateTimeFormat: DateTimeFormat.none, // Updated from printTime
    ),
  );

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      _logger.d("Fetching user profile for UID: ${user.uid}"); // Debugging
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
              : ''; // Kosongkan jika tidak ada gambar
        } else {
          _logger.w("Dokumen pengguna tidak ditemukan di Firestore."); // Warning
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
    User? user = _auth.currentUser;
    if (user != null) {
      Map<String, dynamic> dataToUpdate = {};
      if (username != null) dataToUpdate['username'] = username;
      dataToUpdate['bio'] = bio ?? '';

      if (profileImage != null) {
        try {
          Reference storageRef =
              _storage.ref().child('profile_pictures').child('${user.uid}.jpg');
          UploadTask uploadTask = storageRef.putFile(profileImage);
          TaskSnapshot snapshot = await uploadTask;
          String downloadUrl = await snapshot.ref.getDownloadURL();
          dataToUpdate['profilePicture'] = downloadUrl;
          _logger.d("Profile picture uploaded. URL: $downloadUrl"); // Debugging
        } catch (e, stacktrace) {
          _logger.e("Error uploading profile picture: $e", error: e, stackTrace: stacktrace);
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
    User? user = _auth.currentUser;
    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(
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
