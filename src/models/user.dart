// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Users {
  final int id;
  final String email;
  final String password;

  Users({
    required this.id,
    required this.email,
    required this.password,
  });

  Users copyWith({
    int? id,
    String? email,
    String? password,
  }) {
    return Users(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, email: $email, password: $password)';

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;

    return other.id == id && other.email == email && other.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ password.hashCode;
}
