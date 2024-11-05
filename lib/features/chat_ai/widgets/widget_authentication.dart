import 'package:flutter/material.dart';
import 'package:your_ai/features/app/components/my_big_textbutton.dart';
import 'package:your_ai/features/auth/login/presentation/login_or_register_screen.dart';
import 'package:your_ai/utils/CustomTextStyles.dart';

class AuthenticationWidget extends StatefulWidget {
  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  bool isLoggedIn = false;

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
      return LoggedInFooter(onLogOut: logOut);
    } else {
      return SignInFooter(onSignIn: signIn);
    }
  }
}

class LoggedInFooter extends StatelessWidget {
  final Function()? onLogOut;

  LoggedInFooter({required this.onLogOut});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle, size: 40, color: Colors.blue),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'lqk21112003',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'lqk21112003@gmail.com',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
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
                value: 50 / 50, // Phần trăm sử dụng token
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
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
    return MyBigTextButton(text: 'Sign in / Sign up', onTap: onSignIn);
  }
}
