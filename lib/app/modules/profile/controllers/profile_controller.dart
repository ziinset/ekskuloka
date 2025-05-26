import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final statusController = TextEditingController();
  final emailController = TextEditingController();
  final tanggalLahirController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Load existing data
    namaController.text = 'Goldi Bangun Amukti';
    statusController.text = 'Pelajar Gokil';
    emailController.text = 'johndoe@example.com';
    tanggalLahirController.text = 'DD / MM /YYY';
  }

  void updateProfile() {
    if (formKey.currentState!.validate()) {
      // Show success message
      Get.snackbar(
        'Berhasil',
        'Profile berhasil diupdate!',
        backgroundColor: const Color(0xFF2DB5A5),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
      );

      // Return updated data
      Get.back(result: {
        'nama': namaController.text,
        'status': statusController.text,
        'email': emailController.text,
        'tanggal_lahir': tanggalLahirController.text,
      });
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    statusController.dispose();
    emailController.dispose();
    tanggalLahirController.dispose();
    super.onClose();
  }
}