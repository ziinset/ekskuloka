import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    // Implementasi login
    String username = usernameController.text;
    String password = passwordController.text;

    // Validasi
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Username dan password harus diisi',
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Proses login
    // Ganti dengan implementasi login sesuai kebutuhan
    Get.snackbar(
      'Login Berhasil',
      'Selamat datang $username',
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}