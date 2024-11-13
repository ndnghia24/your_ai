// create widget to test the auth feature domain and data layers

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:your_ai/features/auth/domain/auth_usecases_factory.dart';

final locator = GetIt.instance;

class TestAuthScreen extends StatelessWidget {
  const TestAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthUseCaseFactory authUseCaseFactory = locator<AuthUseCaseFactory>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final res = await authUseCaseFactory.loginUseCase
                    .execute('ndnghia242@gmail.com', 'Ndnghia24');
                print(res);
                Fluttertoast.showToast(
                    msg: res.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: () async {
                final res = await authUseCaseFactory.signUpUseCase
                    .execute('ndnghia242@gmail.com', 'Ndnghia24', 'Nghia ne');
                print(res);
                Fluttertoast.showToast(
                    msg: res.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () async {
                final res =
                    await authUseCaseFactory.getUserInfoUseCase.execute();
                // toast(res.toString());
                Fluttertoast.showToast(
                    msg: res.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: const Text('Get Info'),
            ),
            ElevatedButton(
              onPressed: () async {
                final res = await authUseCaseFactory.logoutUseCase.execute();
                Fluttertoast.showToast(
                    msg: res.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
