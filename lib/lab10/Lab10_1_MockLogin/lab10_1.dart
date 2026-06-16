import 'package:flutter/material.dart';

// ======================
// ENTRY POINT
// ======================

void runLab10_1() {
  runApp(const Lab10App());
}

// ======================
// APP
// ======================

class Lab10App extends StatelessWidget {
  const Lab10App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lab10 Mock Login",
      home: const LoginScreen(),
    );
  }
}

// ======================
// LOGIN SCREEN
// ======================

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

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool isLoading = false;

  bool hidePassword = true;

  // ======================
  // MOCK LOGIN
  // ======================

  Future<void> login() async {

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Fake API delay
    await Future.delayed(
      const Duration(seconds: 2),
    );

    setState(() {
      isLoading = false;
    });

    String email =
        emailController.text.trim();

    String password =
        passwordController.text;

    // Mock credentials
    if (email ==
            "admin@gmail.com" &&
        password == "123456") {

      String mockToken =
          "mock_token_123";

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              HomeScreen(
            token: mockToken,
          ),
        ),
      );
    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          backgroundColor:
              Colors.red,
          content: Text(
            "Invalid email or password",
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
          "Lab10 Mock Login",
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),

          child: Card(
            elevation: 6,

            child: Padding(
              padding:
                  const EdgeInsets.all(
                      20),

              child: Form(
                key: _formKey,

                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    const Icon(
                      Icons.lock,
                      size: 80,
                      color:
                          Colors.blue,
                    ),

                    const SizedBox(
                        height: 20),

                    // EMAIL

                    TextFormField(
                      controller:
                          emailController,

                      decoration:
                          const InputDecoration(
                        labelText:
                            "Email",
                        border:
                            OutlineInputBorder(),
                      ),

                      validator:
                          (value) {

                        if (value ==
                                null ||
                            value
                                .isEmpty) {
                          return "Enter email";
                        }

                        if (!value
                            .contains(
                                "@")) {
                          return "Invalid email";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                        height: 15),

                    // PASSWORD

                    TextFormField(
                      controller:
                          passwordController,

                      obscureText:
                          hidePassword,

                      decoration:
                          InputDecoration(
                        labelText:
                            "Password",

                        border:
                            const OutlineInputBorder(),

                        suffixIcon:
                            IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons
                                    .visibility
                                : Icons
                                    .visibility_off,
                          ),

                          onPressed:
                              () {

                            setState(
                                () {
                              hidePassword =
                                  !hidePassword;
                            });
                          },
                        ),
                      ),

                      validator:
                          (value) {

                        if (value ==
                                null ||
                            value
                                .isEmpty) {
                          return "Enter password";
                        }

                        if (value
                                .length <
                            6) {
                          return "Minimum 6 characters";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                        height: 25),

                    SizedBox(
                      width:
                          double
                              .infinity,

                      height: 50,

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
                                    "LOGIN",
                                  ),
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    const Text(
                      "Demo Account",
                      style:
                          TextStyle(
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const Text(
                      "admin@gmail.com",
                    ),

                    const Text(
                      "123456",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ======================
// HOME SCREEN
// ======================

class HomeScreen
    extends StatelessWidget {

  final String token;

  const HomeScreen({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Home"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green,
            ),

            const SizedBox(
                height: 20),

            const Text(
              "Login Successful",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 10),

            Text(
              "Token:\n$token",
              textAlign:
                  TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}