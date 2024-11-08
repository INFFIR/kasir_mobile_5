// all_activity/services/history_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/history_model.dart';

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
}
