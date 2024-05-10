import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http_sharedpreference/pages/halaman_anime.dart';
import 'package:http_sharedpreference/pages/halaman_kucing.dart';
import 'package:http_sharedpreference/pages/halaman_profile.dart';
import 'package:http_sharedpreference/pages/halaman_utama.dart';

class HalamanHome extends StatelessWidget {
  const HalamanHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Home"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HalamanProfile()));
              },
              icon: Icon(Icons.settings)),
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HalamanUtama()));
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HalamanKucing()));
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 100,
                color: Colors.yellow,
                child: Center(
                  child: Text("Fakta Kucing", style: TextStyle(fontSize: 30)),
                ),
              ),
            )),
        GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HalamanAnime()));
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 100,
                color: Colors.lightBlue,
                child: Center(
                  child: Text("Quotes Animeh", style: TextStyle(fontSize: 30)),
                ),
              ),
            ))
      ],
    );
  }
}
