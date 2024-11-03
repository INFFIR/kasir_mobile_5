import 'package:get/get.dart';
import '../controllers/storage_controller.dart';

class StorageBinding extends Bindings {
  @override
  void dependencies() {
    // Tidak perlu lagi mengirim 'shopId' ke konstruktor
    Get.lazyPut<StorageController>(() => StorageController());
  }
}
