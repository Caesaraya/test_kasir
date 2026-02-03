import 'package:get/get.dart';
import '../models/produk_model.dart';

class CartController extends GetxController {
  RxMap<ProdukModel, int> cartItems = <ProdukModel, int>{}.obs;

  void addToCart(ProdukModel produk) {
    cartItems[produk] = (cartItems[produk] ?? 0) + 1;
  }

  int get totalHarga {
    int total = 0;
    cartItems.forEach((produk, qty) {
      total += produk.harga * qty;
    });
    return total;
  }

  void clearCart() {
    cartItems.clear();
  }
}
