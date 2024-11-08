import 'package:get/get.dart';
import '../controllers/pilih_toko_controller.dart';

class PilihTokoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PilihTokoController>(() => PilihTokoController());
  }
}
