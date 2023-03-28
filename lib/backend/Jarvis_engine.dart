import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jarvisgpt/backend/api_secret.dart';

class ApiService {
  Future<Map<String, dynamic>> getDataFromJarvis(String query) async {
    final response = await http.post(
      // code-davinci-002
      Uri.parse(
          'https://api.openai.com/v1/engines/text-davinci-003/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $api_key',
      },
      // 256
      body: jsonEncode({
        'prompt': query,
        'max_tokens': 256,
        'temperature': 0,
      }),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get data from Jarvis');
    }
    // return;
  }
}
