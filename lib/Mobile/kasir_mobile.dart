import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/roti_controller.dart';
import '../controllers/cart_controller.dart';
import '../models/produk_model.dart';
import '../widgets/product_card.dart';
import '../routes/app_routes.dart';

class MobileKasir extends StatelessWidget {
  MobileKasir({super.key, required RotiController controller});

  final rotiC = Get.find<RotiController>();
  final cartC = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kasir"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.defaultDialog(
                title: "Pesanan",
                content: Obx(() {
                  if (cartC.cartItems.isEmpty) {
                    return const Text("Keranjang kosong");
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: cartC.cartItems.entries.map((e) {
                      return ListTile(
                        title: Text(e.key.nama),
                        subtitle: Text(
                          "${e.value} x | ${e.key.harga * e.value}",
                        ),
                      );
                    }).toList(),
                  );
                }),
                confirm: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.payment);
                  },
                  child: const Text("Bayar"),
                ),
              );
            },
          ),
        ],
      ),

      body: StreamBuilder(
        stream: rotiC.getRoti(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("Produk belum ada"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];

              final produk = ProdukModel.fromFirestore(
                doc.id,
                doc.data() as Map<String, dynamic>,
              );

              return ProductCard(
                product: produk,
                onTap: () => cartC.addToCart(produk),
              );
            },
          );
        },
      ),
    );
  }
}
