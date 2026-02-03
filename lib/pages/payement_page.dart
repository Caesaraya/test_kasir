import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/roti_controller.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key});

  final cartC = Get.find<CartController>();
  final rotiC = Get.find<RotiController>();

  Future<void> prosesPembayaran() async {
    try {
      for (final entry in cartC.cartItems.entries) {
        final produk = entry.key;
        final qty = entry.value;

        await rotiC.kurangiStok(produk, qty);
      }

      cartC.clearCart();

      Get.back(); // kembali ke kasir
      Get.snackbar("Sukses", "Pembayaran berhasil");
    } catch (e) {
      Get.snackbar("Gagal", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pembayaran")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Total Bayar", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              "Rp ${cartC.totalHarga}",
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: prosesPembayaran,
              child: const Text("Bayar"),
            ),
          ],
        ),
      ),
    );
  }
}
