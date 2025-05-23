import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService{
  static const String baseurl = 'http://localhost:8000';

  static Future<User?> login(String email, String password) async{
    try{
      final response = await http.post(
        Uri.parse("$baseurl/login"),
        headers: {'Content-type':'application/json'},
        body: jsonEncode({"email":email,"password":password}),
      );
      if (response.statusCode == 200){
        return User.fromJson(jsonDecode(response.body));
      }
      else{
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'login Failed');
      }
    }
    catch(e){
      throw Exception(e);
    }
  }

  static Future<User?> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseurl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "first_name": firstName,
          "last_name": lastName,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("Signup successful: $responseData");
        return User.fromJson(responseData);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Signup failed. Please try again.');
      }
    } catch (e) {
      throw Exception('Error occurred: ${e.toString()}');
    }
  }
}