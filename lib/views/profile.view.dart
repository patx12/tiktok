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
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF4FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: MainHeader(account: UserData.account)),
          SliverToBoxAdapter(child: InfoHeader(account: UserData.account)),
          const SliverToBoxAdapter(child: Divider(height: 1)),
          SliverToBoxAdapter(child: FriendList(friends: UserData.friends)),
          SliverToBoxAdapter(child: Container(height: 8, color: Colors.grey)),
          const SliverToBoxAdapter(child: PostsTitle()),
          SliverList.builder(
            itemCount: UserData.posts.length,
            itemBuilder: (context, i) => PostItem(post: UserData.posts[i]),
          ),
          // keeps the last post clear of the phone's navigation bar
          SliverToBoxAdapter(child: SizedBox(height: bottomInset + 24)),
        ],
      ),
    );
  }
}