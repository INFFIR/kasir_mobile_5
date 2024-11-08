import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PilihTokoCard extends StatelessWidget {
  final DocumentSnapshot shop;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const PilihTokoCard({
    super.key,
    required this.shop,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFD9D9D9);
    const Color contentColor = Color(0xFF28374C);
    const BorderRadius cardBorderRadius = BorderRadius.all(Radius.circular(15.0));
    const double cardHeight = 100.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: cardHeight,
        child: Card(
          color: backgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: cardBorderRadius,
            side: BorderSide(color: Colors.blueGrey, width: 1),
          ),
          child: InkWell(
            borderRadius: cardBorderRadius,
            onTap: onTap,
            child: Row(
              children: [
                // Leading Icon
                Container(
                  width: cardHeight,
                  height: cardHeight,
                  decoration: const BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                    ),
                  ),
                  child: const Icon(Icons.store, color: contentColor, size: 40),
                ),
                // Title and other content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      shop['name'] ?? 'Tidak ada nama toko',
                      style: const TextStyle(
                        color: contentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Trailing IconButton
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 28),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
