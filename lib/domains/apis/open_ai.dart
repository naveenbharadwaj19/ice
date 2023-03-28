import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

/// Open AI
class OpenAI {
  final String _baseUrl = "https://api.openai.com/v1";
  final String _apiKey = dotenv.env["API_KEY"] as String;
  final String _model = "gpt-3.5-turbo";
  final String _role = "user";

  /// handle chat completion req's
  ///
  /// __Params__
  ///
  /// - [string] content
  ///
  /// __returns__
  ///
  /// - [http.Response]
  Future<http.Response?> chatCompletion(String content) async {
    try {
      Uri url = Uri.parse("$_baseUrl/chat/completions");
      var body = json.encode({
        "model": _model,
        "messages": [
          {
            "role": _role,
            "content": content,
          }
        ]
      });
      var response = await http.post(url, body: body, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_apiKey",
      });
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
