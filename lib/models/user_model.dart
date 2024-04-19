class User {
  final String id;
  final String email;
  final String username;
  final String location;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'].toString(),
      username: json['username'].toString(),
      location: json['location'].toString(),
    );
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, username: $username, location: $location}';
  }

}
