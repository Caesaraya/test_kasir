import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/roti_controller.dart';
import '../widgets/custom_textfield.dart';

class RotiFormPage extends GetView<RotiController> {
  RotiFormPage({super.key});

  final String? id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final isEdit = id != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Roti" : "Tambah Roti")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => CustomTextField(
                label: "Nama Roti",
                initialValue: controller.namaC.value,
                onChanged: (val) => controller.namaC.value = val,
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => CustomTextField(
                label: "Harga",
                keyboardType: TextInputType.number,
                initialValue: controller.hargaC.value,
                onChanged: (val) => controller.hargaC.value = val,
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => CustomTextField(
                label: "Stok",
                keyboardType: TextInputType.number,
                initialValue: controller.stokC.value,
                onChanged: (val) => controller.stokC.value = val,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (isEdit) {
                  await controller.updateRoti(id!);
                } else {
                  await controller.tambahRoti();
                }
                Get.back();
              },
              child: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
