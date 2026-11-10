import 'package:flutter/material.dart';
import 'auth/login.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFDF4FF),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: const LoginPage(),
    );
  }
}