import 'package:flutter/material.dart';

void showPasswordDialog(BuildContext context, Function(String) onPasswordEntered) {
  final TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter Password'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String password = passwordController.text;
              Navigator.of(context).pop(); // Close the dialog
              onPasswordEntered(password); // Pass the password to the callback
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}