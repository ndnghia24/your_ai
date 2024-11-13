import 'package:your_ai/core/storage/spref/spref.dart';
import 'package:your_ai/features/auth/data/data_sources/auth_remote_datasource.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  const AuthRepository(this._authRemoteDataSource);

  Future<Map<String, dynamic>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username}) async {
    final response = await _authRemoteDataSource.signUpWithEmailAndPassword(
        email: email, password: password, username: username);
    return response;
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await _authRemoteDataSource.signInWithEmailAndPassword(
        email: email, password: password);

    if (response['isSuccess']) {
      await SPref.instance.setAccessToken(response['data']['accessToken']);
      await SPref.instance.saveRefreshToken(response['data']['refreshToken']);
    }

    return response;
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    final response = await _authRemoteDataSource.getUserInfo();
    return response;
  }

  Future<Map<String, dynamic>> signOut() async {
    final response = await _authRemoteDataSource.signOut();
    return response;
  }
}
