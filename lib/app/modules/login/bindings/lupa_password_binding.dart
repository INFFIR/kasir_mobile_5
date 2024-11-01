// lib/modules/lupa_password/lupa_password_binding.dart
import 'package:get/get.dart';
import '../controllers/lupa_password_controller.dart';


class LupaPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LupaPasswordController>(() => LupaPasswordController());
  }
}
