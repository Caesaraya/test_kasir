import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_kasir/Desktop/kasir_desktop.dart';
import 'package:model_kasir/Mobile/kasir_mobile.dart';
import '../controllers/roti_controller.dart';
import '../widgets/responsive_layout.dart';

class KasirPage extends GetView<RotiController> {
  const KasirPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: MobileKasir(controller: controller),
      tabletBody: DesktopKasir(controller: controller),
      desktopBody: DesktopKasir(controller: controller),
    );
  }
}