import 'account.dart';
import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';

class UserData {
  static const account = Account(
  name: 'Michael Velez',
  email: 'Michaelvelez1123@gmail.com',
  imageUrl: 'assets/me.jpg',
  followers: 15,
  following: 150,
  posts: 350,
);

static const friends = [
  Friend(name: 'Alice', imageUrl: 'assets/alice.jpg'),
  Friend(name: 'Bob', imageUrl: 'assets/bob.jpg'),
  Friend(name: 'Charlie', imageUrl: 'assets/charlie.jpg'),
  Friend(name: 'Diana', imageUrl: 'assets/dianne.jpg'),
  Friend(name: 'Ethan', imageUrl: 'assets/ethan.jpg'),
  Friend(name: 'Michael', imageUrl: 'assets/michael.jpg'),
];

  static const posts = [
    UserPost(
      name: 'John Doe',
      avatarUrl: 'https://i.pravatar.cc/100?img=14',
      time: '2 hrs ago.',
      caption: 'Had a great day at the beach!',
      imageAsset: 'assets/pavlova.jpg',
      count: 5,
      comments: [
        UserComment(
          name: 'Jane Smith',
          imageUrl: 'https://i.pravatar.cc/100?img=47',
          comment: 'Wow Beautiful!',
          time: '6 hrs',
        ),
        UserComment(
          name: 'Kenneth Vladimir',
          imageUrl: 'https://i.pravatar.cc/100?img=13',
          comment: 'Wow Beautiful!',
          time: '2 hrs',
        ),
        UserComment(
          name: 'Miko Rojo',
          imageUrl: 'https://i.pravatar.cc/100?img=15',
          comment: 'Wow Beautiful!',
          time: '8 hrs',
        ),
      ],
    ),
  ];
}