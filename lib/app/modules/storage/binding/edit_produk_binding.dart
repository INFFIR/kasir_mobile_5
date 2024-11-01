import 'package:get/get.dart';
import '../controllers/edit_produk_controller.dart';

class EditProdukBinding extends Bindings {
  @override
  void dependencies() {
    // Tidak perlu lagi mengirim 'shopId' dan 'productId' ke konstruktor
    Get.lazyPut<EditProdukController>(() => EditProdukController());
  }
}
