import 'package:flutter/material.dart';

class LoginController {
  // Method untuk handle login
  Future<void> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    try {
      // Validasi input
      if (username.isEmpty || password.isEmpty) {
        _showErrorDialog(context, 'Username dan password tidak boleh kosong');
        return;
      }

      // Simulasi proses login (ganti dengan logic API sebenarnya)
      await _performLogin(username, password);

      // Jika login berhasil, navigasi ke home
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      // Handle error
      if (context.mounted) {
        _showErrorDialog(context, 'Login gagal: ${e.toString()}');
      }
    }
  }

  // Simulasi proses login - ganti dengan API call sebenarnya
  Future<bool> _performLogin(String username, String password) async {
    // Simulasi delay untuk loading
    await Future.delayed(const Duration(seconds: 1));

    // Contoh validasi sederhana (ganti dengan logic sebenarnya)
    if (username == 'admin' && password == 'admin123') {
      return true;
    } else if (username == 'Goldi' && password == '12345') {
      return true;
    } else {
      throw Exception('Username atau password salah');
    }
  }

  // Method untuk menampilkan error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Method untuk logout (bisa digunakan di halaman lain)
  void logout(BuildContext context) {
    // Clear any stored user data/tokens here

    // Navigate back to login
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Method untuk validasi email format
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Method untuk validasi password strength
  bool isValidPassword(String password) {
    // Minimal 6 karakter
    return password.length >= 6;
  }
}
