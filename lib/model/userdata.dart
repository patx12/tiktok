import 'account.dart';
import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';

String _pic(int id) => 'https://i.pravatar.cc/100?img=$id';

UserComment _comment(String name, int picId, String time) => UserComment(
      name: name,
      imageUrl: _pic(picId),
      comment: 'Wow Beautiful!',
      time: time,
    );

class UserData {
  static const account = Account(
    name: 'Patrick Pajaron',
    email: 'patrickpajaron@gmail.com',
    imageUrl: 'assets/me.jpg',
    followers: 15,
    following: 150,
    posts: 350,
  );

  static const _friendFiles = {
    'Alice': 'alice',
    'Bob': 'bob',
    'Charlie': 'charlie',
    'Diana': 'dianne',
    'Ethan': 'ethan',
    'Michael': 'michael',
  };

  static final friends = _friendFiles.entries
      .map((e) => Friend(name: e.key, imageUrl: 'assets/${e.value}.jpg'))
      .toList();

  // final (not const) so comments can be added at runtime
  static final posts = [
    UserPost(
      name: 'John Doe',
      avatarUrl: _pic(14),
      time: '2 hrs ago.',
      caption: 'Had a great day at the beach!',
      imageAsset: 'assets/pavlova.jpg',
      count: 5,
      comments: [
        _comment('Jane Smith', 47, '6 hrs'),
        _comment('Kenneth Vladimir', 13, '2 hrs'),
        _comment('Miko Rojo', 15, '8 hrs'),
      ],
    ),
  ];
}