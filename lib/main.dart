import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:your_ai/core/theme/app_theme.dart';
import 'package:your_ai/features/app/presentation/blocs/conversation_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/model_bloc.dart';

import 'configs/service_locator.dart';
import 'core/routes/route.dart';
import 'features/auth/presentation/blocs/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await dotenv.load(fileName: ".env");

  // Setup service locator
  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    locator<AuthBloc>().close();
    locator<ConversationBloc>().close();
    locator<ModelBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );

    debugPaintSizeEnabled = false;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your AI',
      theme: ThemeConfig.lightMode,
      darkTheme: ThemeConfig.darkMode,
      getPages: AppPages.routes,
      initialRoute: Routes.splash,
    );
  }
}

/*
ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: lightThemeColors(context).primary,
    textTheme: textTheme(context),
    appBarTheme: appBarTheme(context),
    inputDecorationTheme: inputDecorationData(context),
    colorScheme: lightThemeColors(context),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: lightThemeColors(context).onSecondary,
      selectionColor: lightThemeColors(context).onSecondary.withOpacity(0.4),
      selectionHandleColor: lightThemeColors(context).onSecondary,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: darkThemeColors(context).primary,
    textTheme: textTheme(context),
    appBarTheme: appBarTheme(context),
    colorScheme: darkThemeColors(context),
    inputDecorationTheme: inputDecorationData(context),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: darkThemeColors(context).onSecondary,
      selectionColor: darkThemeColors(context).onSecondary.withOpacity(0.4),
      selectionHandleColor: darkThemeColors(context).onSecondary,
    ),
  );
}

ColorScheme lightThemeColors(context) {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFffffff),
    onPrimary: Color(0xFF00213b),
    //
    secondary: Color(0xFF0078d4),
    onSecondary: Color(0xFF00213b),
    //
    surfaceContainer: Color(0xFFf5f5f5),
    surfaceDim: Color(0xFF94a3b8),
    surface: Color(0xFFffffff),
    onSurface: Color(0xFF00213b),
    //
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
  );
}

ColorScheme darkThemeColors(context) {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFffffff),
    onPrimary: Color(0xFF00213b),
    //
    secondary: Color(0xFF0078d4),
    onSecondary: Color(0xFF00213b),
    //
    surfaceContainer: Color(0xFFf5f5f5),
    surfaceDim: Color(0xFF94a3b8),
    surface: Color(0xFFffffff),
    onSurface: Color(0xFF00213b),
    //
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
  );
}

appBarTheme(context) {
  return AppBarTheme(
    backgroundColor: lightThemeColors(context).surface,
    titleTextStyle: Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(color: lightThemeColors(context).primary),
  );
}

InputDecorationTheme inputDecorationData(context) {
  return InputDecorationTheme(
    hintStyle: TextStyle(
      color: lightThemeColors(context).onSecondary,
    ),
  );
}

textTheme(BuildContext context) {
  return TextTheme(
    headlineSmall: TextStyle(
      fontSize: 16,
      color: lightThemeColors(context).onSecondary,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      color: lightThemeColors(context).onSecondary,
    ),
  );
}
*/
