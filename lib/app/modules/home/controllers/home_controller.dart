import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  final String shopId;
  var userRole = 'employee'.obs;

  HomeController({required this.shopId});

  @override
  void onInit() {
    super.onInit();
    fetchUserRole();
  }

  void fetchUserRole() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot shopSnapshot =
        await FirebaseFirestore.instance.collection('shops').doc(shopId).get();

    if (shopSnapshot.exists && shopSnapshot['ownerId'] == userId) {
      userRole.value = 'owner';
    } else {
      userRole.value = 'employee';
    }
  }
}
