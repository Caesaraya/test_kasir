import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:model_kasir/models/produk_model.dart';

class RotiController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final namaC = ''.obs;
  final hargaC = ''.obs;
  final stokC = ''.obs;
  final searchC = ''.obs;

  CollectionReference get rotiRef => firestore.collection('roti');

  Stream<QuerySnapshot> getRoti() {
    return rotiRef.snapshots();
  }

  Future<void> tambahRoti() async {
    await rotiRef.add({
      'nama': namaC.value,
      'harga': int.parse(hargaC.value),
      'stok': int.parse(stokC.value),
      'createdAt': Timestamp.now(),
    });
  }

  Future<void> updateRoti(String id) async {
    await rotiRef.doc(id).update({
      'nama': namaC.value,
      'harga': int.parse(hargaC.value),
      'stok': int.parse(stokC.value),
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> hapusRoti(String id) async {
    await rotiRef.doc(id).delete();
  }

  Future<void> kurangiStok(ProdukModel produk, int jumlahBeli) async {
    final docRef = firestore.collection('roti').doc(produk.id);

    await firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      final stokSekarang = snapshot['stok'];
      final stokBaru = stokSekarang - jumlahBeli;

      if (stokBaru < 0) {
        throw Exception("Stok tidak mencukupi");
      }

      transaction.update(docRef, {'stok': stokBaru});
    });
  }

  void setForm({required String nama, required int harga, required int stok}) {
    namaC.value = nama;
    hargaC.value = harga.toString();
    stokC.value = stok.toString();
  }

  void clearForm() {
    namaC.value = '';
    hargaC.value = '';
    stokC.value = '';
  }
}
