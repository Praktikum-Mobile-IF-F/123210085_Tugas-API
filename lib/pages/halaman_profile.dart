import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanProfile extends StatelessWidget {
  const HalamanProfile({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Halaman Profile"),
          backgroundColor: Colors.blue,
        ),
        body: ProfilePage(),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String accountName = '';
  String accountPassword = '';
  String accountDate = '';

  @override
  void initState() {
    super.initState();
    _ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: NetworkImage("https://picsum.photos/100"),
        ),
        SizedBox(height: 16),
        Text("Username : $accountName", style: TextStyle(fontSize: 24)),
        Text("Password : $accountPassword", style: TextStyle(fontSize: 24)),
        Text("Tanggal Lahir : $accountDate", style: TextStyle(fontSize: 24)),
      ],
    );
  }

  Future<void> _ambilData() async {
    final jembatan = await SharedPreferences.getInstance();

    if (jembatan.containsKey('myData')) {
      final myData =
          jsonDecode(jembatan.getString('myData')!) as Map<String, dynamic>;

      setState(() {
        accountName = myData['username'];
        accountPassword = myData['password'];
        accountDate = myData['tanggal_lahir'] ??
            ''; // Tambahkan penanganan jika tanggal lahir tidak ada
      });
    }
  }
}
