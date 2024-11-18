import '../../data/repositories/auth_repository.dart';

class GetUserInfoUseCase {
  final AuthRepository authRepository;

  GetUserInfoUseCase(this.authRepository);

  Future<Map<String, dynamic>> execute() async {
    try {
      var result = await authRepository.getLocalUserInfo();

      if (result['username'] == 'N/A' || result['email'] == 'N/A') {
        final remoteUserInfo = await authRepository.getRemoteUserInfo();
        if (remoteUserInfo['isSuccess']) {
          result = remoteUserInfo['data'];
        } else {
          return {
            'isSuccess': false,
            'data': {
              'username': 'N/A',
              'email': 'N/A',
            }
          };
        }
      }

      final username = result['username'];
      final email = result['email'];

      return {
        'isSuccess': true,
        'data': {
          'username': username,
          'email': email,
        },
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'data': {
          'username': 'N/A',
          'email': 'N/A',
        }
      };
    }
  }
}
