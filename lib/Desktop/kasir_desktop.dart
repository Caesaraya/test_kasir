import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_kasir/controllers/cart_controller.dart';
import '../controllers/roti_controller.dart';
import '../models/produk_model.dart';
import '../routes/app_routes.dart';
import '../widgets/product_card.dart';



class DesktopKasir extends StatelessWidget {
  DesktopKasir({super.key, required RotiController controller});

  final rotiC = Get.find<RotiController>();
  final cartC = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
   body: Row(
  children: [
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


    // ================= KIRI : PRODUK =================
    Expanded(
      flex: 3,
      child: StreamBuilder(
        stream: rotiC.getRoti(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return Obx(() {
            final filtered = docs.where((doc) {
              final nama = doc['nama'].toString().toLowerCase();
              return nama.contains(rotiC.searchC.value);
            }).toList();

            if (filtered.isEmpty) {
              return const Center(
                child: Text("Produk tidak ditemukan"),
              );
            }

         return GridView.builder(
  padding: const EdgeInsets.all(16),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,        // jumlah kolom
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 0.8,    // sesuaikan tinggi card
  ),
  itemCount: filtered.length,
  itemBuilder: (context, index) {
    final doc = filtered[index];
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

          });
        },
      ),
    ),

    // ================= KANAN : KERANJANG =================
    Container(
      width: 280,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          left: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🔍 SEARCH (PINDAH KE ATAS KERANJANG)
          TextField(
            onChanged: (value) {
              rotiC.searchC.value = value.toLowerCase();
            },
            decoration: InputDecoration(
              hintText: "Cari roti...",
              prefixIcon: const Icon(Icons.search),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            "Keranjang",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Divider(),

          // 🛒 LIST PESANAN
          Expanded(
            child: Obx(() {
              if (cartC.cartItems.isEmpty) {
                return const Center(
                  child: Text("Keranjang kosong"),
                );
              }

              return ListView(
                children: cartC.cartItems.entries.map((e) {
                  return ListTile(
                    dense: true,
                    title: Text("${e.key.nama} x${e.value}"),
                    trailing: Text(
                      "Rp ${e.key.harga * e.value}",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),
              );
            }),
          ),

          const Divider(),

          // 💰 TOTAL
          Obx(() => Text(
                "Total : Rp ${cartC.totalHarga}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )),

          const SizedBox(height: 12),

          // 💳 BAYAR
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.payment);
              },
              child: const Text("Bayar"),
            ),
          ),
        ],
      ),
    ),
  ],
),
    );
  }
}
