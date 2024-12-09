import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/routes/route.dart';
import 'package:your_ai/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:your_ai/features/auth/presentation/blocs/auth_event.dart';
import 'package:your_ai/features/auth/presentation/blocs/auth_state.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Trigger the CheckAuthStatusEvent as soon as the SplashScreen is built
    locator<AuthBloc>().add(CheckAuthStatusEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<AuthState>(
        stream: locator<AuthBloc>().stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset(
                'assets/images/loading_capoo.gif',
                width: 200.0,
                height: 200.0,
              ),
            );
          }

          final state = snapshot.data;

          if (state != null) {
            // Handle error as needed
          }

          if (state is AuthAuthenticated) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Get.offAllNamed(Routes.home);
            });
          } else if (state is AuthUnauthenticated) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Get.offAllNamed(Routes.auth);
            });
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
