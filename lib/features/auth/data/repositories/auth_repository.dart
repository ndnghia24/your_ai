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
      await SPref.instance
          .setJarvisAccessToken(response['data']['accessToken']);
      await SPref.instance
          .setJarvisRefreshToken(response['data']['refreshToken']);

      final userInfo = await _authRemoteDataSource.getUserInfo();
      if (response['isSuccess']) {
        await SPref.instance.saveUserInfo(userInfo['data']);
      }
    }
    return response;
  }

  Future<Map<String, dynamic>> getLocalUserInfo() async {
    final response = await SPref.instance.getLocalUserInfo();
    return response;
  }

  Future<Map<String, dynamic>> getRemoteUserInfo() async {
    final response = await _authRemoteDataSource.getUserInfo();
    return response;
  }

  Future<Map<String, dynamic>> getUserUsage() async {
    final response = await _authRemoteDataSource.getUserUsage();
    return response;
  }

  Future<Map<String, dynamic>> signOut() async {
    final response = await _authRemoteDataSource.signOut();
    if (response['isSuccess']) {
      await SPref.instance.deleteAll();
    }
    return response;
  }
}
