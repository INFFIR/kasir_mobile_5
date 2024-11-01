class ProductModel {
  String id;
  String name;
  String description;
  int price;
  int quantity;
  String imageUrl;

  ProductModel({
    required this.id,
    this.name = 'Produk Tidak Tersedia',
    this.description = 'Deskripsi tidak tersedia',
    this.price = 0,
    this.quantity = 0,
    this.imageUrl = '',
  });

  factory ProductModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ProductModel(
      id: documentId,
      name: data['name'] ?? 'Produk Tidak Tersedia',
      description: data['description'] ?? 'Deskripsi tidak tersedia',
      price: data['price'] ?? 0,
      quantity: data['quantity'] ?? 0,
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name.isNotEmpty ? name : 'Produk Tanpa Nama',
      'description': description,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }
}
