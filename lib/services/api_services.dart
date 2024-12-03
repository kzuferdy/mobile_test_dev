import 'package:http/http.dart' as http;
import 'package:mobile_test_dev/models/user.dart';
import 'dart:convert';

class ApiService {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}