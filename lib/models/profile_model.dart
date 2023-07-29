class ProfileModel {
  final String profilePicture;
  final String fullName;
  final String username;
  final String bio;
  final int following;
  final int followedBy;
  final int postsCount;

  const ProfileModel({
    required this.profilePicture,
    required this.username,
    required this.bio,
    required this.following,
    required this.followedBy,
    required this.postsCount,
    required this.fullName,
  });
}
