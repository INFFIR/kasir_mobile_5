import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KelolaAkunPegawaiCard extends StatelessWidget {
  final DocumentSnapshot employeeData;
  final VoidCallback onTap;

  const KelolaAkunPegawaiCard({
    super.key,
    required this.employeeData,
    required this.onTap,
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
                  child: const Icon(Icons.person, color: contentColor, size: 40),
                ),
                // Title and other content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(employeeData['userId'])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Error loading user data');
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Text('User data not found');
                        }
                        var userData = snapshot.data!;
                        return Text(
                          userData['username'] ?? 'No username',
                          style: const TextStyle(
                            color: contentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
