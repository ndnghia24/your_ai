import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Jarvis',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Login or Sign up to access your account',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.blue,
            tabs: const [
              Tab(text: 'Login'),
              Tab(text: 'Sign Up'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLoginForm(),
                _buildSignUpForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildGoogleButton('Login with Google'),
            _buildDivider('or continue with email'),
            _buildEmailField(),
            _buildPasswordField(),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot password?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            _buildSubmitButton('Login'),
            const SizedBox(height: 20),
            _buildTermsText('signing in with an account'),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildGoogleButton('Sign Up with Google'),
            _buildDivider('or continue with email'),
            _buildEmailField(),
            _buildPasswordField(),
            _buildConfirmPasswordField(),
            const SizedBox(height: 20),
            _buildSubmitButton('Sign Up'),
            const SizedBox(height: 20),
            _buildTermsText('signing up with an account'),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleButton(String text) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Image.asset('assets/google_logo.png', height: 24), // Add your Google logo asset
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(color: Colors.grey),
      ),
    );
  }

  Widget _buildDivider(String text) {
    return Row(
      children: <Widget>[
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(text),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email Address',
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextField(
      obscureText: _obscureConfirmPassword,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildSubmitButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(text),
    );
  }

  Widget _buildTermsText(String actionText) {
    return Text.rich(
      TextSpan(
        text: 'By $actionText, you agree to Jarvis\'s ',
        children: const [
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}