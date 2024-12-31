import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/core/routes/route.dart';
import 'package:your_ai/core/theme/app_colors.dart';
import 'package:your_ai/features/app/presentation/blocs/token_bloc.dart';
import 'package:your_ai/features/app/presentation/blocs/token_state.dart';
import 'package:your_ai/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:your_ai/features/auth/presentation/blocs/auth_event.dart';
import 'package:your_ai/features/auth/presentation/blocs/auth_state.dart';

class AuthenticationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: GetIt.I<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AuthAuthenticated) {
          final userInfo = state.userInfo;
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_circle,
                        size: 40, color: AppColors.primary),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userInfo['username'] ?? 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            userInfo['email'] ?? 'N/A',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Token Usage'),
                    BlocBuilder<TokenBloc, TokenState>(
                      builder: (context, state) {
                        if (state is TokenLoaded) {
                          return Text(state.remainingQuery == -1
                              ? '∞'
                              : '${state.remainingQuery}/${state.totalQuery}');
                        } else if (state is TokenLoading) {
                          return CircularProgressIndicator();
                        } else {
                          return Text('N/A');
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                BlocBuilder<TokenBloc, TokenState>(
                  builder: (context, state) {
                    if (state is TokenLoaded) {
                      return LinearProgressIndicator(
                        value: state.remainingQuery / state.totalQuery,
                        backgroundColor: Colors.white,
                        color: Colors.blueAccent,
                        minHeight: 6.0,
                        borderRadius: BorderRadius.circular(8.0),
                      );
                    } else {
                      return LinearProgressIndicator(
                        value: 0,
                        backgroundColor: Colors.grey[300],
                        color: Colors.grey.shade700,
                      );
                    }
                  },
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      GetIt.I<AuthBloc>().add(LogoutEvent());
                      Get.offAllNamed(Routes.auth);
                    },
                    child:
                        Text('Logout', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          );
        } else if (state is AuthUnauthenticated) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(Routes.auth);
                },
                child: Text('Login In / Sign Up',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        } else {
          return Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}
