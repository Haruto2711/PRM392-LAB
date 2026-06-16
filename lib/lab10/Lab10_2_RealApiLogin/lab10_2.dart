import 'package:flutter/material.dart';

import 'auth_service.dart';

void runLab10_2() {
  runApp(const Lab10_2_App());
}

class Lab10_2_App extends StatelessWidget {
  const Lab10_2_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab10_2',
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  bool isLoading = false;

  Future<void> login() async {

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    try {

      setState(() {
        isLoading = true;
      });

      final result =
          await authService.login(
        usernameController.text,
        passwordController.text,
      );

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            username:
                result['username'],
            token:
                result['accessToken'] ??
                '',
          ),
        ),
      );

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          backgroundColor:
              Colors.red,
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Real API Login',
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              TextFormField(
                controller:
                    usernameController,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Username',
                  border:
                      OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {
                    return 'Enter username';
                  }

                  return null;
                },
              ),

              const SizedBox(
                  height: 15),

              TextFormField(
                controller:
                    passwordController,

                obscureText: true,

                decoration:
                    const InputDecoration(
                  labelText:
                      'Password',
                  border:
                      OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {
                    return 'Enter password';
                  }

                  return null;
                },
              ),

              const SizedBox(
                  height: 25),

              SizedBox(
                width:
                    double.infinity,

                child:
                    ElevatedButton(

                  onPressed:
                      isLoading
                          ? null
                          : login,

                  child:
                      isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'LOGIN',
                            ),
                ),
              ),

              const SizedBox(
                  height: 20),

              const Text(
                'Demo Account',
                style: TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const Text(
                'Username: emilys',
              ),

              const Text(
                'Password: emilyspass',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen
    extends StatelessWidget {

  final String username;
  final String token;

  const HomeScreen({
    super.key,
    required this.username,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.verified_user,
              color: Colors.green,
              size: 80,
            ),

            const SizedBox(
                height: 20),

            Text(
              'Welcome $username',
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 20),

            const Text(
              'Access Token:',
            ),

            const SizedBox(
                height: 10),

            Text(
              token,
              textAlign:
                  TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}