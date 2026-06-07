import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool hidePassword = true;

  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ĐĂNG NHẬP"),
      ),
      body: Center(
        child: Card(
          elevation: 6,
          margin:
              const EdgeInsets.all(20),
          child: Padding(
            padding:
                const EdgeInsets.all(20),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                TextField(
                  controller:
                      emailController,
                  decoration:
                      const InputDecoration(
                    labelText: "Email",
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller:
                      passwordController,
                  obscureText:
                      hidePassword,
                  decoration:
                      InputDecoration(
                    labelText:
                        "Mật khẩu",
                    suffixIcon:
                        IconButton(
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility
                            : Icons
                                .visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          hidePassword =
                              !hidePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width:
                      double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
                    child: const Text(
                      "ĐĂNG NHẬP",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}