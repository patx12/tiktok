import 'package:flutter/material.dart';
import '../model/account.dart';

class InfoHeader extends StatelessWidget {
  final Account account;
  const InfoHeader({super.key, required this.account});

  Widget _stat(String label, int value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 15)),
        const SizedBox(height: 4),
        Text('$value',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _stat('Followers', account.followers),
          _stat('Following', account.following),
          _stat('Post', account.posts),
        ],
      ),
    );
  }
}