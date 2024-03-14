class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final DateTime? dob;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    this.dob,
  });
}
