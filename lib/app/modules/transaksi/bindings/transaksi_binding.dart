// bindings/transaksi_binding.dart
import 'package:get/get.dart';
import '../controllers/transkaksi_controller.dart';

class TransaksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransaksiController>(() => TransaksiController());
  }
}
