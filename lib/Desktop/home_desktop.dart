import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/roti_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/roti_list.dart';


class DesktopHome extends StatelessWidget {
  final RotiController controller;
  const DesktopHome({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 🔥 SIDEBAR
          Container(
            width: 250,
            color: Colors.brown.shade300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Toko Roti",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: const Text("Home",
                      style: TextStyle(color: Colors.white)),
                  onTap: () => Get.offAllNamed(AppRoutes.home),
                ),
                ListTile(
                  leading:
                      const Icon(Icons.point_of_sale, color: Colors.white),
                  title: const Text("Kasir",
                      style: TextStyle(color: Colors.white)),
                  onTap: () => Get.offAllNamed(AppRoutes.kasir),
                ),
              ],
            ),
          ),

          // 🔥 CONTENT
          Expanded(
            child: Scaffold(
              appBar: AppBar(title: const Text("Data Roti")),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  controller.clearForm();
                  Get.toNamed(AppRoutes.formroti);
                },
                child: const Icon(Icons.add),
              ),
              body: RotiList(controller: controller, isGrid: true),
            ),
          ),
        ],
      ),
    );
  }
}
