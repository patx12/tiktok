import 'usercomment.dart';

class UserPost {
  final String name;
  final String avatarUrl;
  final String time;
  final String caption;
  final String imageAsset;
  final int count;
  final List<UserComment> comments;

  const UserPost({
    required this.name,
    required this.avatarUrl,
    required this.time,
    required this.caption,
    required this.imageAsset,
    required this.count,
    required this.comments,
  });
}