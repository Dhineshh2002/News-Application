import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert {
  Future<void> termsAndServiceAlert(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Sign in failed'),
          content: const Text(
              '''Please indicate that you are accept the terms and service'''),
          actions: [
            CupertinoButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  Future<void> emailAlreadyTakenAlert(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Sign in failed'),
          content: const  Text('The email you entered have been already in use'),
          actions: [
            CupertinoButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> wrongUserCredential(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Login failed'),
          content: const Text(
              '''Your username or password are incorrect.\nPlease try again'''),
          actions: [
            CupertinoButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}