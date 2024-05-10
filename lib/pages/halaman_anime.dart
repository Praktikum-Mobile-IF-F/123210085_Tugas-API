import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanAnime extends StatefulWidget {
  @override
  _HalamanAnimeState createState() => _HalamanAnimeState();
}

class _HalamanAnimeState extends State<HalamanAnime> {
  String quotes = "";
  String anime = "";
  String char = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://animechan.xyz/api/random'));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      setState(() {
        anime = responseData['anime'];
        char = responseData['character'];
        quotes = responseData['quote'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes Anime'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quotes Anime",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Text(
              anime,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              char,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              quotes,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
