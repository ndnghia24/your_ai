import 'package:your_ai/features/auth/data/data_sources/services/auth_services.dart';

class AuthRemoteDataSource {
  final AuthService _authService;
  const AuthRemoteDataSource(this._authService);

  Future<Map<String, dynamic>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username}) async {
    try {
      final response = await _authService.signup(
        {
          'email': email,
          'password': password,
          'username': username,
        },
      );

      if (response.statusCode == 201) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'Register successful',
        };
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        return {
          'data': response.data['details'][0]['issue'],
          'isSuccess': false,
          'message': 'Email already exists',
        };
      } else {
        return {
          'data': {'details': response.data['details']},
          'isSuccess': false,
          'message': 'Invalid credentials',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message': '${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authService.login(
        {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return {
          'data': response.data['token'],
          'isSuccess': true,
          'message': 'Login successful',
        };
      } else {
        return {
          'data': {'details': response.data['details']},
          'isSuccess': false,
          'message': 'Invalid credentials',
        };
      }
    } catch (e) {
      return {
        'isSuccess': false,
        'message': '${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> signInWithGoogleToken(String googleToken) async {
    try {
      final response = await _authService.loginWithGoogleToken(googleToken);

      if (response.statusCode == 200) {
        return {
          'data': response.data['token'],
          'isSuccess': true,
          'message': 'Login successful',
        };
      } else {
        return {
          'data': {'details': response.data['details']},
          'isSuccess': false,
          'message': 'Invalid credentials',
        };
      }
    } catch (e) {
      return {
        'isSuccess': false,
        'message': '${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final userInfo = await _authService.getUserInfo();

      if (userInfo.statusCode == 200) {
        return {
          'data': userInfo.data,
          'isSuccess': true,
          'message': 'User info fetched successfully',
        };
      } else {
        return {
          'data': userInfo.data,
          'isSuccess': false,
          'message': 'Error occurred during fetching user info',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message': 'Error occurred during fetching user info: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> getUserUsage() async {
    try {
      final userUsage = await _authService.getTokenUsage();

      if (userUsage.statusCode == 200) {
        return {
          'data': userUsage.data,
          'isSuccess': true,
          'message': 'User usage fetched successfully',
        };
      } else {
        return {
          'data': userUsage.data,
          'isSuccess': false,
          'message': 'Error occurred during fetching user usage',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message': 'Error occurred during fetching user usage: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> signOut() async {
    try {
      final response = await _authService.logout();

      if (response.statusCode == 200) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'Logout successful',
        };
      } else {
        return {
          'data': response.data,
          'isSuccess': false,
          'message': 'Error occurred during logout',
        };
      }
    } catch (e) {
      return {
        'data': e.toString(),
        'isSuccess': false,
        'message': 'Error occurred during logout: ${e.toString()}',
      };
    }
  }
}
