import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/roti_controller.dart';
import '../models/produk_model.dart';
import '../routes/app_routes.dart';
import 'product_card.dart';


class RotiList extends StatelessWidget {
  final RotiController controller;
  final bool isGrid;

  const RotiList({
    super.key,
    required this.controller,
    required this.isGrid,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.getRoti(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        return Obx(() {
          final filtered = docs.where((doc) {
            final nama = doc['nama'].toString().toLowerCase();
            return nama.contains(controller.searchC.value);
          }).toList();

          if (filtered.isEmpty) {
            return const Center(child: Text("Produk tidak ditemukan"));
          }

          // 🖥 DESKTOP / TABLET
          if (isGrid) {
            final width = MediaQuery.of(context).size.width;
            final crossAxisCount = width >= 1400
                ? 5
                : width >= 1100
                    ? 4
                    : 3;

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 4 / 3,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final doc = filtered[index];
                final product = ProdukModel(
                  id: doc.id,
                  nama: doc['nama'],
                  harga: doc['harga'],
                  stok: doc['stok'],
                );

                return ProductCard(
                  product: product,
                  onTap: () {
                    controller.setForm(
                      nama: product.nama,
                      harga: product.harga,
                      stok: product.stok,
                    );
                    Get.toNamed(AppRoutes.formroti,
                        arguments: product.id);
                  },
                );
              },
            );
          }

          // 📱 MOBILE
          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final doc = filtered[index];
              final product = ProdukModel(
                id: doc.id,
                nama: doc['nama'],
                harga: doc['harga'],
                stok: doc['stok'],
              );

              return ProductCard(
                product: product,
                onTap: () {
                  controller.setForm(
                    nama: product.nama,
                    harga: product.harga,
                    stok: product.stok,
                  );
                  Get.toNamed(AppRoutes.formroti,
                      arguments: product.id);
                },
              );
            },
          );
        });
      },
    );
  }
}
