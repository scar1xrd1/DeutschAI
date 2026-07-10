import 'package:flutter/material.dart';

class DeutschAIApp extends StatelessWidget {
  const DeutschAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeutschAI',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('DeutschAI')),
        body: const Center(
          child: Text('Добро пожаловать!', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
