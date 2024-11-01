class Shop {
  final String id;
  final String name;
  final String ownerId;

  Shop({required this.id, required this.name, required this.ownerId});

  factory Shop.fromMap(Map<String, dynamic> data, String documentId) {
    return Shop(
      id: documentId,
      name: data['name'] ?? '',
      ownerId: data['ownerId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ownerId': ownerId,
    };
  }
}
