import 'package:get/get.dart';
import '../controllers/roti_controller.dart';

class RotiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RotiController>(() => RotiController());
  }
}
