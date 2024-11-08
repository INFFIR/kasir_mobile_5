// KirimMailPage.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_mobile_5/app/modules/components/widgets/bottom_nav_bar.dart';

class KirimMailPage extends StatefulWidget {
  final String? initialRecipient;
  final String? initialSubject;

  const KirimMailPage({
    super.key,
    this.initialRecipient,
    this.initialSubject,
  });

  @override
  _KirimMailPageState createState() => _KirimMailPageState();
}

class _KirimMailPageState extends State<KirimMailPage> {
  late TextEditingController _penerimaController;
  late TextEditingController _subjekController;
  late TextEditingController _pesanController;

  @override
  void initState() {
    super.initState();
    _penerimaController =
        TextEditingController(text: widget.initialRecipient ?? '');
    _subjekController =
        TextEditingController(text: widget.initialSubject ?? '');
    _pesanController = TextEditingController();
  }

  @override
  void dispose() {
    _penerimaController.dispose();
    _subjekController.dispose();
    _pesanController.dispose();
    super.dispose();
  }

  void _kirimMail() async {
    String penerima = _penerimaController.text.trim();
    String subjek = _subjekController.text.trim();
    String pesan = _pesanController.text.trim();

    if (penerima.isEmpty || subjek.isEmpty || pesan.isEmpty) {
      // Menampilkan pesan error jika ada field yang kosong
      Get.snackbar(
        'Error',
        'Semua field harus diisi.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // Optional: Add email format validation
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(penerima)) {
      Get.snackbar(
        'Error',
        'Format email tidak valid.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // Logika untuk mengirim email
    // Anda dapat mengintegrasikan dengan backend atau layanan email di sini

    // Menampilkan pop-up dialog setelah berhasil mengirim
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Email telah dikirimkan!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                Get.back(); // Kembali ke halaman sebelumnya
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // Optional: Reset form after sending
    // _penerimaController.clear();
    // _subjekController.clear();
    // _pesanController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kirim Mail'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _penerimaController,
              decoration: InputDecoration(
                labelText: 'Penerima',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _subjekController,
              decoration: InputDecoration(
                labelText: 'Subjek',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _pesanController,
              decoration: InputDecoration(
                labelText: 'Pesan',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _kirimMail,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Kirim Email'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
