import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_sharedpreference/pages/halaman_register.dart';
import 'package:http_sharedpreference/pages/halamanhome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        backgroundColor: Colors.blue,
      ),
      body: const LoginPage(),
    ));
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  String accountName = '';
  String accountPassword = '';
  bool cekVerifikasi = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _usernameField(),
          const SizedBox(height: 16),
          _passwordField(),
          const SizedBox(height: 16),
          _buttonLogin(),
          const SizedBox(height: 16),
          _textButtonRegister()
        ],
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      enabled: true,
      onChanged: (value) {
        setState(() {
          username = value;
        });
      },
      decoration: const InputDecoration(
        hintText: 'username',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      enabled: true,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      decoration: const InputDecoration(
        hintText: 'password',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      onPressed: () {
        _login(context, username, password);
      },
      child: const Text("Login"),
    );
  }

  Widget _textButtonRegister() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HalamanRegister()),
        );
      },
      child: const Text("Register Disini"),
    );
  }

  Future<void> _login(
      BuildContext context, String username, String password) async {
    final jembatan = await SharedPreferences.getInstance();

    if (jembatan.containsKey('myData')) {
      final myData =
          jsonDecode(jembatan.getString('myData')!) as Map<String, dynamic>;

      final accountName = myData['username'];
      final accountPassword = myData['password'];

      if (accountName == username && password == accountPassword) {
        // Login berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HalamanHome()),
        );
      }
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Center(
              child: Text(
                'Username atau password tidak sesuai!',
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        },
      );
    }
  }
}
