import '../../data/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<Map<String, dynamic>> execute() async {
    try {
      final result = await authRepository.signOut();

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
