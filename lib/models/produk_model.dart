class ProdukModel {
  final String id;
  final String nama;
  final int harga;
  final int stok;

  ProdukModel({
    required this.id,
    required this.nama,
    required this.harga,
    required this.stok,
  });

  factory ProdukModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ProdukModel(
      id: id,
      nama: data['nama'],
      harga: data['harga'],
      stok: data['stok'],
    );
  }
}
