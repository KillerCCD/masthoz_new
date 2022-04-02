import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:mashtoz_flutter/domens/models/email.dart';
import 'package:mashtoz_flutter/domens/models/full_name.dart';
import 'package:mashtoz_flutter/domens/models/passowrd.dart';

class RegisterState extends Equatable {
  final FullName fullName;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
 
  const RegisterState({
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  RegisterState copyWith({
    FullName? fullName,
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    print("from Login State : $status");
    return RegisterState(
      fullName: fullName??this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [fullName,email, password, status, errorMessage];
}
