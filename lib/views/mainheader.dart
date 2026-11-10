import 'package:flutter/material.dart';
import '../model/account.dart';

class MainHeader extends StatelessWidget {
  final Account account;
  const MainHeader({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: NetworkImage(account.imageUrl),
        ),
        const SizedBox(height: 8),
        Text(
          account.name,
          style: const TextStyle(
              fontSize: 28, fontWeight: FontWeight.w500, letterSpacing: 1),
        ),
        Text(account.email, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}