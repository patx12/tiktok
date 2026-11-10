import 'package:flutter/material.dart';
import '../model/userpost.dart';

class PostList extends StatelessWidget {
  final List<UserPost> posts;
  const PostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Posts',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          for (final p in posts) _PostItem(post: p),
        ],
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  final UserPost post;
  const _PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(post.avatarUrl)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Row(children: [
                  Text(post.time),
                  const SizedBox(width: 4),
                  const Icon(Icons.group, size: 14),
                ]),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(post.caption),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(post.imageAsset,
              width: double.infinity, height: 220, fit: BoxFit.cover),
        ),
        const Divider(height: 24),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Action(icon: Icons.thumb_up, label: 'Like', color: Colors.blue),
            _Action(icon: Icons.comment, label: 'comment', color: Colors.grey),
            _Action(icon: Icons.share, label: 'Share', color: Colors.grey),
          ],
        ),
        const Divider(height: 24),
        Text('${post.count}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        const Row(children: [
          Text('All comments', style: TextStyle(fontSize: 18)),
          Icon(Icons.arrow_drop_down),
        ]),
        const SizedBox(height: 8),
        for (final c in post.comments)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(backgroundImage: NetworkImage(c.imageUrl)),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3EDF7),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600)),
                          Text(c.comment),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6, top: 4),
                      child: Text('${c.time}     Like     Reply',
                          style: const TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Action(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: color, size: 20),
      const SizedBox(width: 6),
      Text(label, style: TextStyle(color: color)),
    ]);
  }
}