// lib/modules/sign_up/sign_up_binding.dart
import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart';


class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
