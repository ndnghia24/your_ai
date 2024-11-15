import '../../data/repositories/auth_repository.dart';

class GetUserInfoUseCase {
  final AuthRepository authRepository;

  GetUserInfoUseCase(this.authRepository);

  Future<Map<String, dynamic>> execute() async {
    try {
      final result = await authRepository.getUserInfo();

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
