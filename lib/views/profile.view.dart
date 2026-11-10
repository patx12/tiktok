import 'package:flutter/material.dart';
import '../model/userdata.dart';
import 'friendlist.dart';
import 'infoheader.dart';
import 'mainheader.dart';
import 'postlist.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF4FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainHeader(account: UserData.account),
            InfoHeader(account: UserData.account),
            const Divider(height: 1),
            FriendList(friends: UserData.friends),
            Container(height: 8, color: Colors.grey),
            PostList(posts: UserData.posts),
          ],
        ),
      ),
    );
  }
}