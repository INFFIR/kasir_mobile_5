// bindings/pilih_tempat_kerja_binding.dart
import 'package:get/get.dart';
import '../controllers/pilih_tempat_kerja_controller.dart';

class PilihTempatKerjaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PilihTempatKerjaController>(() => PilihTempatKerjaController());
  }
}
