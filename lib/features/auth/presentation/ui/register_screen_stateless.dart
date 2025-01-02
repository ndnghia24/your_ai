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

class RegisterScreen extends StatelessWidget {
  final Function()? onTap;
  RegisterScreen({super.key, required this.onTap});

  // Text Editing controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form Keys
  final usernameFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();
  final confirmPasswordFormKey = GlobalKey<FormState>();

  // Action method
  Future<void> signUserUp(BuildContext context) async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password == confirmPassword) {
      // Trigger SignUpEvent
      locator<AuthBloc>().add(SignUpEvent(email, password, username));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
    }
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
              // Custom Appbar
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: verticalPadding),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              // Welcome Message
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome to Your AI',
                        style: GoogleFonts.bebasNeue(fontSize: 30)),
                    Text('Create a new account')
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // Input fields (username, email, password, confirm password)
              _buildTextFormField(
                  formKey: usernameFormKey,
                  controller: usernameController,
                  hintText: 'Name',
                  obscureText: false),
              SizedBox(height: 10),
              _buildTextFormField(
                  formKey: emailFormKey,
                  controller: emailController,
                  hintText: 'Email Address',
                  obscureText: false),
              SizedBox(height: 10),
              _buildTextFormField(
                  formKey: passwordFormKey,
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true),
              SizedBox(height: 10),
              _buildTextFormField(
                  formKey: confirmPasswordFormKey,
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true),
              SizedBox(height: 25),

              // Sign Up button with Bloc
              BlocListener<AuthBloc, AuthState>(
                bloc: locator<AuthBloc>(),
                listener: (context, state) {
                  if (state is AuthUnauthenticated &&
                      state.message == 'Sign up success') {
                    Get.offAllNamed(Routes.auth);
                  } else if (state is AuthUnauthenticated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
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
                                    passwordFormKey.currentState!.validate() &&
                                    confirmPasswordFormKey.currentState!
                                        .validate()) {
                                  signUserUp(context);
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
                                    'Sign Up',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const CupertinoActivityIndicator(
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 25),

              // Google Sign-in Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMySquareTile(
                      onTap: () {}, imgPath: 'assets/images/google_logo.png'),
                ],
              ),
              SizedBox(height: 25),

              // Routing to Login Page
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

// Helper methods for TextFormFields
Widget _buildTextFormField({
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String hintText,
  required bool obscureText,
}) {
  return Form(
    key: formKey,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
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
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
      ),
    ),
  );
}
