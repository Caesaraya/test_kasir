import 'package:get/get.dart';
import 'package:model_kasir/pages/form_roti_page.dart';
import 'package:model_kasir/pages/kasir_page.dart';
import 'package:model_kasir/pages/payement_page.dart';
import '../pages/home_page.dart';
import '../bindings/roti_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: RotiBinding(),
    ),
    GetPage(
      name: AppRoutes.formroti,
      page: () => RotiFormPage(),
      binding: RotiBinding(),
    ),
    GetPage(name: AppRoutes.kasir, page: () => KasirPage()),
    GetPage(name: AppRoutes.payment, page: () => PaymentPage()),
  ];
}
