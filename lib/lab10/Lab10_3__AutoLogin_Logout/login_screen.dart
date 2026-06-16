import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'home_screen.dart';
import 'session_service.dart';

class LoginScreen
    extends StatefulWidget {

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  final SessionService session =
      SessionService();

  bool loading = false;

  Future<void> login() async {

    try {

      setState(() {
        loading = true;
      });

      final result =
          await authService.login(
        usernameController.text,
        passwordController.text,
      );

      await session.saveToken(
        result['accessToken'],
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const HomeScreen(),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text(e.toString()),
        ),
      );

    } finally {

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:
          AppBar(
        title:
            const Text(
          'Login',
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            TextField(
              controller:
                  usernameController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Username',
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  passwordController,
              obscureText: true,
              decoration:
                  const InputDecoration(
                labelText:
                    'Password',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed:
                  loading
                      ? null
                      : login,
              child:
                  const Text(
                'LOGIN',
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'emilys / emilyspass',
            ),
          ],
        ),
      ),
    );
  }
}