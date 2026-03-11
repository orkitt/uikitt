import 'package:flutter/material.dart';
import 'bootstrap.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: Text('Hello from Orkitt!')),
      ),
    );
  }
}
