import '../../data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Map<String, dynamic>> execute(String email, String password) async {
    try {
      final result = await authRepository.signInWithEmailAndPassword(
          email: email, password: password);

      final data = result['data'];
      final isSuccess = result['isSuccess'];

      return {
        'isSuccess': isSuccess,
        'data': data,
      };
    } catch (e) {
      throw Exception("USECASE Error: ${e.toString()}");
    }
  }
}