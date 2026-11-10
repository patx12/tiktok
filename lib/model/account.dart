class Account {
  final String name;
  final String email;
  final String imageUrl;
  final int followers;
  final int following;
  final int posts;

  const Account({
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.followers,
    required this.following,
    required this.posts,
  });
}