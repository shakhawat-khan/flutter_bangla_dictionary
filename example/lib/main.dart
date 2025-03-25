import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bangla_dictionary/flutter_bangla_dictionary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BanglaDictionaryScreen(),
    );
  }
}

class BanglaDictionaryScreen extends StatefulWidget {
  const BanglaDictionaryScreen({super.key});

  @override
  State<BanglaDictionaryScreen> createState() => _BanglaDictionaryScreenState();
}

class _BanglaDictionaryScreenState extends State<BanglaDictionaryScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _meaning;
  bool _isLoading = false;

  Future<void> _searchWord() async {
    setState(() {
      _isLoading = true;
    });

    String? meaning =
        await FlutterBanglaDictionary.searchWord(_controller.text.trim());
    setState(() {
      _meaning = meaning ?? "Word not found!";
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bangla Dictionary"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Display word meaning
            Text(
              _meaning ?? "Enter a word to search",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // TextField for input
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter English Word",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Search Button
            ElevatedButton(
              onPressed: _isLoading ? null : _searchWord,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Search", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
