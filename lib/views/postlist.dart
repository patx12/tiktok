import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/usercomment.dart';
import '../model/userpost.dart';

const _myName = 'Patrick Pajaron';
const _myPic = 'assets/me.jpg';
const _boldTitle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

// Web links use NetworkImage, local files use AssetImage
CircleAvatar _avatar(String path, {double radius = 20}) {
  final ImageProvider image =
      path.startsWith('http') ? NetworkImage(path) : AssetImage(path);
  return CircleAvatar(radius: radius, backgroundImage: image);
}

UserComment _myComment(String text, String time) =>
    UserComment(name: _myName, imageUrl: _myPic, comment: text, time: time);

// Posts whose saved comments were already loaded this session
final _loadedPosts = <UserPost>{};

class PostsTitle extends StatelessWidget {
  const PostsTitle({super.key});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: const Text('Posts', style: _boldTitle),
      );
}

/// Screen opened when a post is tapped. Reuses PostItem.
class PostDetail extends StatelessWidget {
  final UserPost post;
  const PostDetail({super.key, required this.post});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDF4FF),
          title: Text(post.name),
        ),
        body: SingleChildScrollView(
          child: PostItem(post: post, tappable: false),
        ),
      );
}

class PostItem extends StatefulWidget {
  final UserPost post;
  final bool tappable; // false on the post screen
  const PostItem({super.key, required this.post, this.tappable = true});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  final _controller = TextEditingController();
  bool _liked = false;

  UserPost get _post => widget.post;
  String get _key => 'post_${_post.name}';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('${_key}_comments');
    final firstLoad = _loadedPosts.add(_post);
    if (!mounted) return;

    setState(() {
      _liked = prefs.getBool('${_key}_liked') ?? false;
      if (firstLoad && saved != null) {
        for (final m in jsonDecode(saved) as List) {
          _post.comments.add(_myComment(m['comment'], m['time']));
        }
      }
    });
  }

  // Saves the like and only the comments written by the user
  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final mine = _post.comments
        .where((c) => c.imageUrl == _myPic)
        .map((c) => {'comment': c.comment, 'time': c.time})
        .toList();
    await prefs.setString('${_key}_comments', jsonEncode(mine));
    await prefs.setBool('${_key}_liked', _liked);
  }

  // One helper for every change: update the screen, then save
  void _change(VoidCallback fn) {
    setState(fn);
    _save();
  }

  Future<void> _openDetail() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PostDetail(post: _post)),
    );
    _load();
  }

  void _addComment() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _change(() => _post.comments.add(_myComment(text, 'Just now')));
    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final onOpen = widget.tappable ? _openDetail : null;

    final actions = [
      (
        _liked ? Icons.thumb_up : Icons.thumb_up_outlined,
        'Like',
        _liked ? Colors.blue : Colors.grey,
        () => _change(() => _liked = !_liked),
      ),
      (Icons.comment, 'comment', Colors.grey, onOpen),
      (Icons.share, 'Share', Colors.grey, null),
    ];

    const divider = Divider(height: 24);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(onTap: onOpen, child: _PostBody(post: _post)),
          divider,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final (icon, label, color, onTap) in actions)
                InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(children: [
                      Icon(icon, color: color, size: 20),
                      const SizedBox(width: 6),
                      Text(label, style: TextStyle(color: color)),
                    ]),
                  ),
                ),
            ],
          ),
          divider,
          Text('${_post.count + (_liked ? 1 : 0)}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Row(children: [
            Text('All comments', style: TextStyle(fontSize: 18)),
            Icon(Icons.arrow_drop_down),
          ]),
          const SizedBox(height: 8),
          for (final c in _post.comments) _CommentTile(comment: c),
          _CommentBox(controller: _controller, onSend: _addComment),
        ],
      ),
    );
  }
}

/// Header, caption and photo: the tappable part of a post
class _PostBody extends StatelessWidget {
  final UserPost post;
  const _PostBody({required this.post});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _avatar(post.avatarUrl),
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
        ],
      );
}

class _CommentTile extends StatelessWidget {
  final UserComment comment;
  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avatar(comment.imageUrl),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
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
                        Text(comment.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        Text(comment.comment),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6, top: 4),
                    child: Text('${comment.time}     Like     Reply',
                        style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class _CommentBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  const _CommentBox({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          _avatar(_myPic, radius: 16),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: onSend,
          ),
        ],
      );
}