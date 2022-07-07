import 'dart:convert';

import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final String? fullName;
  final String? password;
  final String? email;
  final int id;
  const Users({
    required this.id,
    this.email,
    this.fullName,
    this.password,
  });

  //factory User.fromJson(String source) => User.fromMap(json.decode(source));
  static const empty = Users(id: 0);

  // Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Users.empty;

  // Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Users.empty;

  Users copyWith({
    String? fullName,
    String? password,
    int? id,
  }) {
    return Users(
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'password': password,
      'email': email,
    };
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      fullName: json['full_name'],
      email: json['email'],
      password: json['password'],
      id: json['id'],
    );
  }

  String toJson() => json.encode(toMap());
  @override
  List<Object?> get props => [fullName, password];
}
