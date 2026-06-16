import 'package:flutter/material.dart';
import 'splash_screen.dart';

void runLab10_3() {
  runApp(
    const Lab10_3_App(),
  );
}

class Lab10_3_App
    extends StatelessWidget {

  const Lab10_3_App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner:
          false,
      title:
          'Lab10_3',
      home:
          const SplashScreen(),
    );
  }
}