import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanRegister extends StatelessWidget {
  const HalamanRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Register"),
      ),
      body: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username = '';
  String password = '';
  late DateTime selectedDate = DateTime.now();

  //untuk menyimpan menggunakan shared preference
  Future<void> setPreference() async {
    final prefs = await SharedPreferences.getInstance();

    final myData = json.encode({
      'username': username,
      'password': password,
      'tanggal_lahir': selectedDate.toIso8601String(),
    });

    prefs.setString('myData', myData);
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 100, left: 20),
          child: _inputName(),
        ),
        Container(
          margin: EdgeInsets.only(right: 100, left: 20, top: 20),
          child: _inputPassword(),
        ),
        Container(
          margin: EdgeInsets.only(right: 100, left: 20, top: 20),
          child: _inputTanggalLahir(context),
        ),
        Container(
          child: _tombolDaftar(),
          margin: EdgeInsets.only(left: 20, top: 20),
        )
      ],
    );
  }

  Widget _inputName() {
    return TextFormField(
      enabled: true,
      onChanged: (value) {
        setState(() {
          username = value;
        });
      },
      decoration: const InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget _inputPassword() {
    return TextFormField(
      obscureText: true,
      enabled: true,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      decoration: const InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget _inputTanggalLahir(BuildContext context) {
    return Row(
      children: [
        Text(
          'Tanggal Lahir: ',
          style: TextStyle(fontSize: 16),
        ),
        TextButton(
          onPressed: () => _selectDate(context),
          child: Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _tombolDaftar() {
    return ElevatedButton(
      onPressed: () {
        setPreference();
        Navigator.pop(context);
      },
      child: const Text("Daftar"),
    );
  }
}
