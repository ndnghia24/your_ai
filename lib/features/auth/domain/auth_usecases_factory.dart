import 'package:your_ai/features/auth/data/repositories/auth_repository.dart';
import 'package:your_ai/features/auth/domain/usecases/google_login_usecase.dart';

import 'usecases/login_usecase.dart';
import 'usecases/signup_usecase.dart';
import 'usecases/get_userinfo_usecase.dart';
import 'usecases/logout_usecase.dart';

class AuthUseCaseFactory {
  final AuthRepository authRepository;

  AuthUseCaseFactory(this.authRepository);

  LoginUseCase get loginUseCase => LoginUseCase(authRepository);
  GoogleLoginUseCase get googleLoginUseCase =>
      GoogleLoginUseCase(authRepository);
  SignUpUseCase get signUpUseCase => SignUpUseCase(authRepository);
  GetUserInfoUseCase get getUserInfoUseCase =>
      GetUserInfoUseCase(authRepository);
  LogoutUseCase get logoutUseCase => LogoutUseCase(authRepository);
}
