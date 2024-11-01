// views/card_storage.dart
import 'package:flutter/material.dart';

class CardStorage extends StatelessWidget {
  final String itemName;
  final String itemQuantity;
  final String itemPrice;
  final String imageUrl;
  final VoidCallback onEdit;

  const CardStorage({
    super.key,
    required this.itemName,
    required this.itemQuantity,
    required this.itemPrice,
    required this.imageUrl,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        height: 150,
        width: 350,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              height: 60,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/default.png',
                                    height: 60);
                              },
                            )
                          : Image.asset('assets/default.png', height: 60),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemName.isNotEmpty ? itemName : 'Tanpa Nama',
                            style: const TextStyle(
                              color: Color(0xFF28374C),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            itemQuantity.isNotEmpty ? itemQuantity : '0 pcs',
                            style: const TextStyle(
                              color: Color(0xFF28374C),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onEdit,
                  child: const Icon(
                    Icons.edit,
                    color: Color(0xFF28374C),
                    size: 24,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Text(
                  itemPrice.isNotEmpty ? itemPrice : 'Rp 0',
                  style: const TextStyle(
                    color: Color(0xFF28374C),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
