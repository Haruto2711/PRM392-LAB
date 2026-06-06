import 'package:flutter/material.dart';

// Entry point của Lab 7
void runLab7() {
  runApp(const SignupApp());
}

class SignupApp extends StatelessWidget {
  const SignupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 7 Signup Form',
      home: const SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController =
      TextEditingController();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final _confirmController =
      TextEditingController();

  // Focus Nodes
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  // =====================
  // VALIDATORS
  // =====================

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Full name is required";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    if (!value.contains('@') ||
        !value.contains('.')) {
      return "Enter a valid email";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Minimum 8 characters";
    }

    if (!RegExp(r'[0-9]')
        .hasMatch(value)) {
      return "Password needs a digit";
    }

    return null;
  }

  String? validateConfirm(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm password";
    }

    if (value !=
        _passwordController.text) {
      return "Passwords do not match";
    }

    return null;
  }

  // =====================
  // SUBMIT
  // =====================

  void submitForm() {

    // Đóng bàn phím
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!
        .validate()) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text("Signup Successful!"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();

    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      // Tắt keyboard khi chạm ngoài
      onTap: () {
        FocusScope.of(context).unfocus();
      },

      child: Scaffold(
        appBar: AppBar(
          title:
              const Text("Signup Form"),
        ),

        body: SingleChildScrollView(
          padding:
              const EdgeInsets.all(16),

          child: Form(
            key: _formKey,

            autovalidateMode:
                AutovalidateMode
                    .onUserInteraction,

            child: Column(
              children: [

                // FULL NAME
                TextFormField(
                  controller:
                      _nameController,
                  focusNode: _nameFocus,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Full Name",
                    border:
                        OutlineInputBorder(),
                  ),

                  textInputAction:
                      TextInputAction.next,

                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(
                            _emailFocus);
                  },

                  validator:
                      validateName,
                ),

                const SizedBox(
                    height: 16),

                // EMAIL
                TextFormField(
                  controller:
                      _emailController,
                  focusNode:
                      _emailFocus,

                  decoration:
                      const InputDecoration(
                    labelText: "Email",
                    border:
                        OutlineInputBorder(),
                  ),

                  textInputAction:
                      TextInputAction.next,

                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(
                            _passwordFocus);
                  },

                  validator:
                      validateEmail,
                ),

                const SizedBox(
                    height: 16),

                // PASSWORD
                TextFormField(
                  controller:
                      _passwordController,
                  focusNode:
                      _passwordFocus,

                  obscureText:
                      obscurePassword,

                  decoration:
                      InputDecoration(
                    labelText:
                        "Password",

                    border:
                        const OutlineInputBorder(),

                    suffixIcon:
                        IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons
                                .visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },
                    ),
                  ),

                  textInputAction:
                      TextInputAction.next,

                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(
                            _confirmFocus);
                  },

                  validator:
                      validatePassword,
                ),

                const SizedBox(
                    height: 16),

                // CONFIRM PASSWORD
                TextFormField(
                  controller:
                      _confirmController,
                  focusNode:
                      _confirmFocus,

                  obscureText:
                      obscureConfirm,

                  decoration:
                      InputDecoration(
                    labelText:
                        "Confirm Password",

                    border:
                        const OutlineInputBorder(),

                    suffixIcon:
                        IconButton(
                      icon: Icon(
                        obscureConfirm
                            ? Icons.visibility
                            : Icons
                                .visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirm =
                              !obscureConfirm;
                        });
                      },
                    ),
                  ),

                  textInputAction:
                      TextInputAction.done,

                  onFieldSubmitted: (_) {
                    submitForm();
                  },

                  validator:
                      validateConfirm,
                ),

                const SizedBox(
                    height: 24),

                SizedBox(
                  width:
                      double.infinity,

                  child:
                      ElevatedButton(
                    onPressed:
                        submitForm,

                    child:
                        const Text(
                      "SIGN UP",
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