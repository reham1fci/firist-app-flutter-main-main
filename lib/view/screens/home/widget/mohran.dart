import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../home_screen.dart';
import '../../../../main.dart';

void main() {
  runApp(HelloWorldApp());
}

class HelloWorldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello, World! mohran'),
        ),
        body: ElevatedButton(
          onPressed: () {
            // Add your button's functionality here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Myapp()),
            );
          },
          child: const Text('Button2'),
        ),
      ),
    );
  }
}
