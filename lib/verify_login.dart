import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class VerifyLogin {
  String inputUsername;
  String inputPassword;
  String username = '';
  String password = '';
  bool cekLogin = false;

  VerifyLogin({required this.inputUsername, required this.inputPassword}) {
    getPreference().then((_) {
      checkCredentials();
    });
  }

  Future<void> getPreference() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('myData')) {
      final myData =
          json.decode(prefs.getString('myData')!) as Map<String, dynamic>;

      username = myData['username'];
      password = myData['password'];
    } else {
      // Penanganan jika data 'myData' tidak ditemukan
      username = '';
      password = '';
    }
  }

  void checkCredentials() {
    if (inputUsername == username && inputPassword == password) {
      // Jika username dan password sesuai
      // Lakukan aksi selanjutnya di sini
      print('Username dan password sesuai');
      cekLogin = true;
      // print(cekLogin);
    } else {
      // Jika username dan password tidak sesuai
      // Lakukan aksi lain di sini
      print('Username atau password tidak sesuai');
      cekLogin = false;
      // print(cekLogin);
    }
  }

  bool verifikasi() {
    if (cekLogin) {
      return true;
    } else {
      return false;
    }
  }
}
