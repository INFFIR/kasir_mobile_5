import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_produk_controller.dart';
import '../utils/storage_exception_handler.dart';

class EditProdukPage extends StatelessWidget {
  const EditProdukPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProdukController controller = Get.find<EditProdukController>();

    ImageProvider<Object> getImageProvider() {
      if (controller.imageFile != null) {
        return FileImage(controller.imageFile!);
      } else if (controller.imageUrl != null &&
          controller.imageUrl!.isNotEmpty) {
        return NetworkImage(controller.imageUrl!);
      } else {
        return const AssetImage('assets/default.png');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT PRODUK', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            color: Colors.white,
            onPressed: controller.updateProduct,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
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
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.jumlahController,
                              decoration: const InputDecoration(
                                labelText: 'Jumlah Barang',
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: controller.tambahJumlahController,
                              decoration: const InputDecoration(
                                labelText: 'Tambah Jumlah',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          int tambahJumlah =
                              int.tryParse(controller.tambahJumlahController.text) ??
                                  0;
                          controller.jumlahBarang.value += tambahJumlah;
                          controller.jumlahController.text =
                              controller.jumlahBarang.value.toString();
                          controller.tambahJumlahController.clear();
                        },
                        child: const Text('Tambah ke Jumlah Barang'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final TextEditingController confirmationController =
                              TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Konfirmasi Penghapusan'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                        'Ketikkan ulang nama produk untuk mengonfirmasi penghapusan:'),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: confirmationController,
                                      decoration: const InputDecoration(
                                        labelText: 'Nama Produk',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Menutup dialog
                                    },
                                    child: const Text('Batal'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      String inputName =
                                          confirmationController.text.trim();
                                      if (inputName ==
                                          controller.namaController.text.trim()) {
                                        controller.deleteProduct();
                                        Navigator.of(context)
                                            .pop(); // Menutup dialog setelah penghapusan
                                      } else {
                                        handleException('Nama produk tidak cocok');
                                      }
                                    },
                                    child: const Text('Hapus'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("Hapus Produk"),
                      ),
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
