class User{
  final String gender;
  final String email;
  final String state;
  final String country;
  final String postcode;
  final UserName userName;
  User( {
    required this.gender,
    required this.email,
    required this.state,
    required this.country,
    required this.postcode,
    required this.userName
});
}

class UserName {
  final String title;
  final String first;
  final String last;
  UserName({
    required this.title,
    required this.first,
    required this.last
});

String get fullName {
  return '${this.first} ${this.last}';
}
}