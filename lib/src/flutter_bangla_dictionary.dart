import 'dart:convert';
import 'package:flutter/services.dart';

class FlutterBanglaDictionary {
  static Future<String?> searchWord(String searchWord) async {
    // Load the JSON file
    final String response =
        await rootBundle.loadString('assets/word/E2Bdatabase.json');
    final List<dynamic> dictionary = json.decode(response);

    // Search for the English word
    for (var item in dictionary) {
      if (item['en'] == searchWord) {
        return item['bn'];
      }
    }

    // If word not found
    return null;
  }
}
