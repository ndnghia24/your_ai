import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_ai/features/app/components/my_big_textbutton.dart';
import 'package:your_ai/features/app/components/my_textfield.dart';

import '../../../../utils/CustomTextStyles.dart';
import '../../../app/components/my_square_tile.dart';

class LoginScreen extends StatelessWidget {
  final Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  /// Text Editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  /// Action methods
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = 25;
    final double verticalPadding = 20;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Custom Appbar
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: verticalPadding),
                child: Row(
                  children: [
                    GestureDetector(
                        // pop the screen
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(CupertinoIcons.back, size: 30))
                  ],
                ),
              ),

              /// Content
              /// /// Welcome Message
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome to Your AI',
                        style: GoogleFonts.bebasNeue(fontSize: 30)),
                    Text('Login to access your account')
                  ],
                ),
              ),
              const SizedBox(height: 25),

              /// /// Input username
              MyTextfield(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 10),

              /// /// Input password
              MyTextfield(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: 10),

              /// /// Forgot password
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password?'),
                  ],
                ),
              ),
              SizedBox(height: 25),

              /// /// Login button
              MyBigTextButton(text: 'Sign In', onTap: signUserIn),
              SizedBox(height: 25),

              /// /// Divider (Or continue with ... )
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 3,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('Or continue with',
                            style: TextStyle(color: Colors.grey.shade700))),
                    Expanded(
                      child: Divider(
                        thickness: 3,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),

              /// /// Google Sign-in Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MySquareTile(
                      onTap: () {}, imgPath: 'assets/images/google_logo.png'),
                  //const SizedBox(width: 10),
                  //MySquareTile(imgPath: 'assets/images/google_logo.png'),
                ],
              ),
              SizedBox(height: 25),

              /// /// Routing to Register Page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      'Register Now',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
