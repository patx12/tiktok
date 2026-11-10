import 'package:flutter/material.dart';
import '../model/friend.dart';

class FriendList extends StatelessWidget {
  final List<Friend> friends;
  const FriendList({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Friends',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text('${friends.length} Friends'),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, i) {
              final f = friends[i];
              return Card(
                margin: EdgeInsets.zero,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        f.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(f.name),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}