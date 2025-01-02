import '../../data/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<Map<String, dynamic>> execute(
      String email, String password, String username) async {
    try {
      final result = await authRepository.signUpWithEmailAndPassword(
          email: email, password: password, username: username);

      final isSuccess = result['isSuccess'];

      return {
        'isSuccess': isSuccess,
        'data': result['data'],
      };
    } catch (e) {
      return {
        'isSuccess': false,
        'data': e.toString(),
      };
    }
  }
}
