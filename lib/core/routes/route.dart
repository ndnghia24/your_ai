import 'package:get/get.dart';
import 'package:your_ai/features/app/home_screen.dart';
import 'package:your_ai/features/auth/presentation/ui/login_or_register_screen.dart';
import 'package:your_ai/features/chat_bot/presentation/chatbot_screen.dart';
import 'package:your_ai/testMain.dart';

class Routes {
  static const String test = '/test';
  static const String auth = '/auth';
  static const String home = '/home';
  static const String chat_ai = '/chat-ai';
  static const String chat_bot = '/chat-bot';
}

class AppPages {
  static final routes = [
    GetPage(name: Routes.test, page: () => AllTestScreen()),
    GetPage(name: Routes.auth, page: () => LoginOrRegisterScreen()),
    GetPage(name: Routes.home, page: () => HomeScreen()),
    GetPage(name: Routes.chat_bot, page: () => ChatBotScreen()),
  ];
}
