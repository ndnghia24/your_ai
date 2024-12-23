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
        'message': 'Error occurred during login: ${e.toString()}',
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

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final response = await _authService.getUserInfo();

      if (response.statusCode == 200) {
        return {
          'data': response.data,
          'isSuccess': true,
          'message': 'User info fetched successfully',
        };
      } else {
        return {
          'data': response.data,
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
