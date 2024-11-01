import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tambah_produk_controller.dart';

class TambahProdukPage extends StatelessWidget {
  const TambahProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TambahProdukController controller = Get.find();

    ImageProvider<Object> getImageProvider() {
      if (controller.imageFile != null) {
        return FileImage(controller.imageFile!);
      } else {
        return const AssetImage('assets/default.png');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('TAMBAH PRODUK', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: Colors.white,
            onPressed: controller.addProduct,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form
          SingleChildScrollView(
            child: Column(
              children: [
                // Form fields
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: getImageProvider(),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: controller.pickImage,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Barang',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.deskripsiController,
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.hargaController,
                        decoration: const InputDecoration(
                          labelText: 'Harga',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller.jumlahController,
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Barang',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
