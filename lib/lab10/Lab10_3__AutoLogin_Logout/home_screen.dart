import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'session_service.dart';

class HomeScreen
    extends StatelessWidget {

  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final SessionService session =
        SessionService();

    return Scaffold(
      appBar: AppBar(
        title:
            const Text(
          'Home',
        ),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () async {

            await session.logout();

            if (!context.mounted) {
              return;
            }

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const LoginScreen(),
              ),
              (route) => false,
            );
          },

          child:
              const Text(
            'LOGOUT',
          ),
        ),
      ),
    );
  }
}