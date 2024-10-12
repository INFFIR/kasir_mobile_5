import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
  runApp(const MaterialApp(
    home: StrukPage(),
  ));
}

class StrukPage extends StatefulWidget {
  const StrukPage({super.key});

  @override
  _StrukPageState createState() => _StrukPageState();
}

class _StrukPageState extends State<StrukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'PEMBAYARAN BERHASIL',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200], // Change to a solid background color if needed
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Center(
                child: Text(
                  '(NAMA TOKO)\n(ALAMAT TOKO)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'TANGGAL :\nXX-XX-XX XX:XX:XX WIB\n'
                'NOMOR REFERENSI :\nID XXX XXX XXX\n',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildItemRow('2 x BARANG 1', 'Rp20.000', 'Rp40.000'),
              _buildItemRow('1 x BARANG 1', 'Rp20.000', 'Rp20.000'),
              const Divider(height: 30, thickness: 2),
              _buildTotalRow('TOTAL', 'Rp60.000'),
              const SizedBox(height: 20),
              const Text(
                'METODE PEMBAYARAN :\nCASH',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildButtonSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(String itemName, String itemPrice, String totalPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(itemName, style: const TextStyle(fontSize: 16)),
        Text(totalPrice, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildTotalRow(String label, String total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(total, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildButtonSection(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(
          context: context,
          label: 'KEMBALI KE BERANDA',
          color: Colors.orange,
          onPressed: () {
            Get.offNamed('/HomePage');
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 350,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
