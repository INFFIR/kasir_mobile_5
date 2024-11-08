// all_activity/models/history_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetail {
  final String id;
  final String name;
  final int quantity;
  final int price;

  ProductDetail({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory ProductDetail.fromMap(Map<String, dynamic> data) {
    return ProductDetail(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 0,
      price: data['price'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}

class History {
  final String id;
  final String username;
  final String email;
  final DateTime timestamp;
  final String activity;
  final String transactionId; // Field baru
  final List<ProductDetail> products; // Field ini wajib

  History({
    required this.id,
    required this.username,
    required this.email,
    required this.timestamp,
    required this.activity,
    required this.transactionId, // Inisialisasi field baru
    required this.products,
  });

  factory History.fromMap(Map<String, dynamic> data, String documentId) {
    var productsFromFirestore = data['products'] as List<dynamic>? ?? [];
    List<ProductDetail> productList = productsFromFirestore
        .map((product) => ProductDetail.fromMap(Map<String, dynamic>.from(product)))
        .toList();

    return History(
      id: documentId,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      activity: data['activity'] ?? '',
      transactionId: data['transactionId'] ?? '', // Mengambil transactionId
      products: productList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'timestamp': timestamp,
      'activity': activity,
      'transactionId': transactionId, // Menyertakan transactionId
      'products': products.map((product) => product.toMap()).toList(),
    };
  }
}
