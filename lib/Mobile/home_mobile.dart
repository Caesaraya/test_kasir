import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_kasir/routes/app_routes.dart';
import '../controllers/roti_controller.dart';
import '../widgets/roti_list.dart';

class MobileHome extends StatelessWidget {
  final RotiController controller;
  const MobileHome({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Toko Roti")),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.brown.shade300),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Toko Roti",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text("Kasir"),
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.kasir);
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clearForm();
          Get.toNamed(AppRoutes.formroti);
        },
        child: const Icon(Icons.add),
      ),

      body: RotiList(controller: controller, isGrid: false),
    );
  }
}
