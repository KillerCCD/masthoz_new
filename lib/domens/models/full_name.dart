import 'package:formz/formz.dart';

enum FullNameValidator { invliad }

class FullName extends FormzInput<String, FullNameValidator> {
  const FullName.pure() : super.pure('');
  const FullName.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
      r"^(?:[ա-ֆԱ-Ֆա-ֆԱ-Ֆ\w+а-яА-Яа-яА-Яa-zA-Z]{3,} [ա-ֆԱ-Ֆա-ֆԱ-Ֆ\w+а-яА-Яа-яА-Яa-zA-Za-zA-Z]{5,}){0,1}$");
  @override
  FullNameValidator? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : FullNameValidator.invliad;
  }
}
