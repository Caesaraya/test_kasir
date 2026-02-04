import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/produk_model.dart';

class ProductCard extends StatelessWidget {
  final ProdukModel product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 600;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: isWide ? _desktopCard() : _mobileCard(),
      ),
    );
  }

  // 📱 MOBILE
  Widget _mobileCard() {
    return ListTile(
      leading: const Icon(Icons.bakery_dining, size: 32),
      title: Text(product.nama),
      subtitle: Text(
        "Harga: Rp ${product.harga}\nStok: ${product.stok}",
      ),
    );
  }

  // 🖥 DESKTOP
  Widget _desktopCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.bakery_dining, size: 40),
          const SizedBox(height: 8),
          Text(
            product.nama,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text("Harga : Rp ${product.harga}"),
          Text("Stok  : ${product.stok}"),
        ],
      ),
    );
  }
}
