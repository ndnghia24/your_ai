import 'package:flutter/material.dart';
import 'package:your_ai/utils/CustomTextStyles.dart';
import 'package:your_ai/features/auth/login/presentation/login_screen.dart';

class AuthenticationWidget extends StatefulWidget {
  @override
  _AuthenticationWidgetState createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  bool isLoggedIn = false; // Biến theo dõi trạng thái đăng nhập

  // Hàm chuyển trạng thái đăng xuất
  void logOut() {
    setState(() {
      isLoggedIn = false;
    });
  }

  // Hàm chuyển trạng thái đăng nhập
  void signIn() {
    setState(() {
      isLoggedIn = true;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? LoggedInFooter(onLogOut: logOut)
        : SignInFooter(onSignIn: signIn);
  }
}

// Widget cho trạng thái đã đăng nhập
class LoggedInFooter extends StatelessWidget {
  final VoidCallback onLogOut;

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

// Widget cho trạng thái chưa đăng nhập
class SignInFooter extends StatelessWidget {
  final VoidCallback onSignIn;

  SignInFooter({required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.blue),
            ),
          ),
          onPressed: onSignIn, // Gọi hàm signIn khi nhấn
          icon: Icon(Icons.account_circle, color: Colors.blue),
          label: Text('Sign in / Sign up',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: CustomTextStyles.captionMedium.fontSize)),
        ),
      ),
    );
  }
}
