import 'package:get/get.dart';
import '../controllers/tambah_produk_controller.dart';

class TambahProdukBinding extends Bindings {
  @override
  void dependencies() {
    // Tidak perlu lagi mengirim 'shopId' ke konstruktor
    Get.lazyPut<TambahProdukController>(() => TambahProdukController());
  }
}
