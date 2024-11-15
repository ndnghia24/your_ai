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
      final data = result['data'];

      return {
        'isSuccess': isSuccess,
        'data': data,
      };
    } catch (e) {
      throw Exception("USECASE Error: ${e.toString()}");
    }
  }
}
