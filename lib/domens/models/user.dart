import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? fullName;
  final String? password;
  final String? email;
  final int id;
  const User({
    required this.id,
    this.email,
    this.fullName,
    this.password,
  });

  //factory User.fromJson(String source) => User.fromMap(json.decode(source));
  static const empty = User(id: 0);

  // Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  // Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  User copyWith({
    String? fullName,
    String? password,
    int? id,
  }) {
    return User(
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
