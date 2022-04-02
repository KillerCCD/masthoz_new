class Validator {
  static final RegExp _emailRegExp = RegExp(
    r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$',
  );
  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static final RegExp _passwordRegExp = RegExp(
    r'[A-Z,a-z,0-9(а-яА-Я)ա-ֆԱ-Ֆ]{6}',
  );

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
