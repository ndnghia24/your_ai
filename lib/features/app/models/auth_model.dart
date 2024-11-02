import 'package:your_ai/features/app/models/user_model.dart';

class AuthModel {
  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  AuthModel({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthModel.initial() => AuthModel(
        tokenType: '',
        accessToken: '',
        refreshToken: '',
        user: UserModel.initial(),
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      tokenType: json['tokenType'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokenType': tokenType,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }
}
