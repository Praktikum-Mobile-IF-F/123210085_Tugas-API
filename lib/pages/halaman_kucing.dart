import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanKucing extends StatefulWidget {
  @override
  _HalamanKucingState createState() => _HalamanKucingState();
}

class _HalamanKucingState extends State<HalamanKucing> {
  List<String> facts = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://cat-fact.herokuapp.com/facts'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<String> fetchedFacts =
          responseData.map((fact) => fact['text'].toString()).toList();
      setState(() {
        facts = fetchedFacts;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fakta Kucing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fakta Kucing",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: facts.length,
                itemBuilder: (context, index) {
                  return Text(
                    facts[index],
                    style: TextStyle(fontSize: 16),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
