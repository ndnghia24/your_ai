import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  final Function()? onTap;
  RegisterScreen({super.key, required this.onTap});

  /// Text Editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordControllder = TextEditingController();

  /// Action methods
  void signUserUp() {}

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
                    Text('Exploring Your AI with new account')
                  ],
                ),
              ),
              const SizedBox(height: 25),

              /// /// Input username
              _buildMyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false),
              SizedBox(height: 10),

              /// /// Input password
              _buildMyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true),
              SizedBox(height: 10),

              /// /// Forgot password
              /// /// Input password
              _buildMyTextField(
                  controller: confirmPasswordControllder,
                  hintText: 'Confirm Password',
                  obscureText: true),
              SizedBox(height: 25),

              /// /// Login button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child:
                    _buildMyBigTextButton(onTap: signUserUp, text: 'Sign Up'),
              ),
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
                  _buildMySquareTile(
                      onTap: () {}, imgPath: 'assets/icons/google.png'),
                ],
              ),
              SizedBox(height: 25),

              /// /// Routing to Register Page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have an account?'),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      'Login Now',
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

Widget _buildMySquareTile(
    {required Function()? onTap, required String imgPath}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade200),
        child: Image.asset(imgPath, height: 40)),
  );
}

Widget _buildMyBigTextButton(
    {required Function()? onTap, required String text}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        padding: const EdgeInsets.all(20),
        //margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )),
  );
}

Widget _buildMyTextField(
    {required TextEditingController controller,
    required String hintText,
    required bool obscureText}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
          fillColor: Colors.white,
          filled: true),
    ),
  );
}
