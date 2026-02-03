import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/roti_controller.dart';
import '../routes/app_routes.dart';

class HomePage extends GetView<RotiController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Toko Roti")),

      // 🔥 DRAWER NAVIGASI
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.brown.shade300),
              child: Align(
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
              onTap: () {
                Get.back(); // tutup drawer
              },
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

      body: StreamBuilder(
        stream: controller.getRoti(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(data['nama']),
                  subtitle: Text(
                    "Harga: ${data['harga']} | Stok: ${data['stok']}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.hapusRoti(data.id),
                  ),
                  onTap: () {
                    controller.setForm(
                      nama: data['nama'],
                      harga: data['harga'],
                      stok: data['stok'],
                    );

                    Get.toNamed(AppRoutes.formroti, arguments: data.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
