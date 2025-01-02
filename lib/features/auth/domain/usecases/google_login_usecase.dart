import 'package:your_ai/features/auth/data/repositories/auth_repository.dart';

class GoogleLoginUseCase {
  final AuthRepository authRepository;

  GoogleLoginUseCase(this.authRepository);

  Future<Map<String, dynamic>> execute(String googleToken) async {
    try {
      final result = await authRepository.signInWithGoogleToken(googleToken);

      final data = result['data'];
      final isSuccess = result['isSuccess'];

      return {
        'isSuccess': isSuccess,
        'data': data,
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'data': e.toString(),
      };
    }
  }
}
