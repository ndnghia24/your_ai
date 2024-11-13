import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_ai/features/auth/data/data_sources/services/auth_services.dart';
import 'package:your_ai/features/auth/presentation/blocs/auth_bloc.dart';

import '../../../../auth/presentation/ui/login_or_register_screen.dart';

class AuthenticationWidget extends StatefulWidget {
  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  bool isLoggedIn = true;

  void logOut() {
    setState(() {
      isLoggedIn = false;
    });
  }

  void signIn() {
    setState(() {
      isLoggedIn = true;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginOrRegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return LoggedInFooter(context: context, onLogOut: logOut);
    } else {
      return SignInFooter(onSignIn: signIn);
    }
  }
}

class LoggedInFooter extends StatelessWidget {
  final Function()? onLogOut;
  final BuildContext context;

  LoggedInFooter({required this.onLogOut, required this.context});

  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await context.read<AuthBloc>().getUserInfo();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle, size: 40, color: Colors.grey.shade700),
              SizedBox(width: 10),
              Expanded(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final userData = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData['username'] ?? 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            userData['email'] ?? 'N/A',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Token Usage 🔥'),
                  Text('50/50'),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: 50 / 50,
                backgroundColor: Colors.grey[300],
                color: Colors.grey.shade700,
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade700, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onLogOut, // Gọi hàm logOut khi nhấn
              child: Text('Log out', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInFooter extends StatelessWidget {
  final Function()? onSignIn;

  SignInFooter({required this.onSignIn});

  @override
  Widget build(BuildContext context) {
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
          onPressed: onSignIn,
          child:
              Text('Login In / Sign Up', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
