import 'package:dio/src/response.dart';

class User {
  final String id;
  final String email;
  final String username;

  User({
    required this.id,
    required this.email,
    required this.username,
  });

  static Future<User> fromJson(Map<String, dynamic> userData) {
    return Future.value(User(
      id: userData['id'],
      email: userData['email'],
      username: userData['username'],
    ));
  }
}
