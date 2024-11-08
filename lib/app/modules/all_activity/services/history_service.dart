// all_activity/services/history_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/history_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addHistory(String shopId, History history) async {
    try {
      await _firestore
          .collection('shops')
          .doc(shopId)
          .collection('histories')
          .add(history.toMap());
    } catch (e) {
      print('Error adding history: $e');
      // Anda dapat menambahkan penanganan kesalahan yang lebih baik di sini
    }
  }

  Stream<List<History>> getHistories(String shopId) {
    return _firestore
        .collection('shops')
        .doc(shopId)
        .collection('histories')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => History.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // Metode baru untuk mengambil history berdasarkan transactionId
  Future<History?> getHistoryByTransactionId(String shopId, String transactionId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('shops')
        .doc(shopId)
        .collection('histories')
        .where('transactionId', isEqualTo: transactionId)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return History.fromMap(snapshot.docs.first.data() as Map<String, dynamic>, snapshot.docs.first.id);
    } else {
      return null;
    }
  }

  // Metode baru untuk menambahkan aktivitas umum
  Future<void> logActivity(String shopId, String activity, {String transactionId = '', List<ProductDetail>? products}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('User not logged in');
      return;
    }

    // Mendapatkan informasi user
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
    String username = userDoc['username'] ?? 'Unknown';
    String email = userDoc['email'] ?? 'Unknown';

    History history = History(
      id: '', // Firestore akan mengenerate ID
      username: username,
      email: email,
      timestamp: DateTime.now(),
      activity: activity,
      transactionId: transactionId,
      products: products ?? [],
    );

    await addHistory(shopId, history);
  }
}
