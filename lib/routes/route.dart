import 'package:get/get.dart';
import 'package:your_ai/features/auth/presentation/ui/login_or_register_screen.dart';
import 'package:your_ai/features/chat_ai/presentation/ui/chat_session_screen.dart';

class Routes {
  static const String auth = '/auth';
  static const String chat_ai = '/chat-ai';
  //static const String chat_prompt = '/chat-prompts';
}

class AppPages {
  static final routes = [
    GetPage(name: Routes.auth, page: () => LoginOrRegisterScreen()),
    GetPage(name: Routes.chat_ai, page: () => ChatScreen()),
    //GetPage(name: Routes.chat_prompt, page: () => ProfileScreen()),
  ];
}
