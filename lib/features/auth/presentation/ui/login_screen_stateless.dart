import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:your_ai/configs/service_locator.dart';
import 'package:your_ai/core/routes/route.dart';

import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';

class LoginScreen extends StatelessWidget {
  final Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  /// Text Editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  /// Action methods
  Future<void> signUserIn(BuildContext context) async {
    final email = usernameController.text;
    final password = passwordController.text;
    locator<AuthBloc>().add(LoginEvent(email, password));
  }

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
                        onTap: () {
                          Get.back();
                        },
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
              _buildEmailTextFormField(
                  formKey: usernameFormKey,
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false),
              SizedBox(height: 10),

              /// /// Input password
              _buildPasswordTextFormField(
                formKey: passwordFormKey,
                controller: passwordController,
                hintText: 'Password',
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
              BlocListener<AuthBloc, AuthState>(
                bloc: locator<AuthBloc>(),
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    Get.offAllNamed(Routes.home);
                  } else if (state is AuthUnauthenticated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  bloc: locator<AuthBloc>(),
                  builder: (context, state) {
                    bool isButtonEnabled = true;

                    if (state is AuthLoading) {
                      isButtonEnabled = false;
                    }

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: GestureDetector(
                        onTap: isButtonEnabled
                            ? () {
                                if (usernameFormKey.currentState!.validate() &&
                                    passwordFormKey.currentState!.validate()) {
                                  signUserIn(context);
                                }
                              }
                            : null,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isButtonEnabled ? Colors.black : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: isButtonEnabled
                                ? Text(
                                    'Login',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                      onTap: () {}, imgPath: 'assets/images/google_logo.png'),
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

Widget _buildSignInButton({required Function()? onTap, required String text}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        padding: const EdgeInsets.all(20),
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

Widget _buildEmailTextFormField(
    {required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required String hintText,
    required bool obscureText}) {
  return Form(
    key: formKey,
    autovalidateMode: AutovalidateMode.disabled,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email cannot be empty';
          }
          final emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
          ).hasMatch(value);
          if (!emailValid) {
            return "Please enter a valid email";
          }
          return null;
        },
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
    ),
  );
}

Widget _buildPasswordTextFormField({
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String hintText,
}) {
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  return Form(
    key: formKey,
    autovalidateMode: AutovalidateMode.disabled,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ValueListenableBuilder<bool>(
        valueListenable: isPasswordVisible,
        builder: (context, value, child) {
          return TextFormField(
            controller: controller,
            obscureText: !value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please input your password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  isPasswordVisible.value = !isPasswordVisible.value;
                },
                child: Icon(
                  value ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
