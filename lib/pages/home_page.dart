import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_kasir/Desktop/home_desktop.dart';
import 'package:model_kasir/Mobile/home_mobile.dart';
import '../controllers/roti_controller.dart';
import '../widgets/responsive_layout.dart';
class HomePage extends GetView<RotiController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: MobileHome(controller: controller),
      tabletBody: DesktopHome(controller: controller),
      desktopBody: DesktopHome(controller: controller),
    );
  }
}