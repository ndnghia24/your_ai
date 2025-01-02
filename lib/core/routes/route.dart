import 'package:get/get.dart';
import 'package:your_ai/features/app/presentation/ui/screens/splash_screen.dart';
import 'package:your_ai/features/app/presentation/ui/screens/home_screen.dart';
import 'package:your_ai/features/auth/presentation/ui/login_or_register_screen.dart';
import 'package:your_ai/features/email_response/presentation/ui/email_srceen.dart';
import 'package:your_ai/features/knowledged_bot/presentation/ui/chatbot_screen.dart';
import 'package:your_ai/testMain.dart';

class Routes {
  static const String splash = '/splash';
  static const String test = '/test';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String chat_ai = '/chat-ai';
  static const String chat_bot = '/chat-bot';
  static const String email_response = '/email-response';
}

class AppPages {
  static final routes = [
    GetPage(name: Routes.splash, page: () => SplashScreen()),
    GetPage(name: Routes.test, page: () => AllTestScreen()),
    GetPage(name: Routes.auth, page: () => LoginOrRegisterScreen()),
    GetPage(name: Routes.home, page: () => HomeScreen()),
    GetPage(name: Routes.chat_bot, page: () => ChatBotScreen()),
    GetPage(name: Routes.chat_ai, page: () => EmailResponseScreen()),
  ];
}
