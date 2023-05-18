// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final int id;
  final String email;
  final String password;
  final String type;
  User({
    this.id = 0,
    this.email = '',
    this.password = '',
    this.type = '',
  });

  User copyWith({
    int? id,
    String? email,
    String? password,
    String? type,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'type': type,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: (map['id'] ?? 0) as int,
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      type: (map['type'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, email: $email, password: $password, type: $type)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.password == password &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ password.hashCode ^ type.hashCode;
  }
}
