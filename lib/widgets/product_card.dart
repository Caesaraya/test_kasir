import 'package:flutter/material.dart';
import '../models/produk_model.dart';

class ProductCard extends StatelessWidget {
  final ProdukModel product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: const Icon(Icons.bakery_dining),
        title: Text(product.nama),
        subtitle: Text("Harga: ${product.harga} | Stok: ${product.stok}"),
        onTap: onTap,
      ),
    );
  }
}
