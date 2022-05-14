import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text(
            'Login',
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/home");
          },
        ),
      ),
    );
  }
}
