import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/auth/domain/auth_usecases_factory.dart';

final locator = GetIt.instance;

class TestAuthScreen extends StatefulWidget {
  const TestAuthScreen({super.key});

  @override
  _TestAuthScreenState createState() => _TestAuthScreenState();
}

class _TestAuthScreenState extends State<TestAuthScreen> {
  final AuthUseCaseFactory authUseCaseFactory = locator<AuthUseCaseFactory>();

  String currentUser = 'No user';
  String statusMessage = 'No status';

  void _updateCurrentUser(String user) {
    setState(() {
      currentUser = user;
    });
  }

  void _updateStatusMessage(String message) {
    setState(() {
      statusMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display current user and status message
            Text('Current User: $currentUser'),
            Text('Status: $statusMessage'),
            const Divider(),

            ElevatedButton(
              onPressed: () async {
                final res = await authUseCaseFactory.loginUseCase
                    .execute('lqk21112003@gmail.com', 'Lqk21112003');
                _updateCurrentUser('lqk21112003@gmail.com');
                _updateStatusMessage(res.toString());

                Fluttertoast.showToast(
                  msg: res.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('Sign In'),
            ),

            ElevatedButton(
              onPressed: () async {
                final res = await authUseCaseFactory.signUpUseCase
                    .execute('ndnghia24@gmail.com', 'Ndnghia24', 'Nghia ne');
                _updateCurrentUser('ndnghia24@gmail.com');
                _updateStatusMessage(res.toString());

                Fluttertoast.showToast(
                  msg: res.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('Sign Up'),
            ),

            ElevatedButton(
              onPressed: () async {
                final res =
                    await authUseCaseFactory.getUserInfoUseCase.execute();
                _updateStatusMessage(res.toString());

                Fluttertoast.showToast(
                  msg: res.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('Get Info'),
            ),

            ElevatedButton(
              onPressed: () async {
                final res = await authUseCaseFactory.logoutUseCase.execute();
                _updateCurrentUser('No user');
                _updateStatusMessage('Logged out');

                Fluttertoast.showToast(
                  msg: res.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
