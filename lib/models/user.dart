class User {
  final String uid;
  final String firstName;
  final String lastName;
  final num age;
  final String email;

  User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'email': email,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      age: json['age'],
    );
  }
}
