class Validation {

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email can't be empty";
    } else if (!(RegExp(
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""")
        .hasMatch(email))) {
      return 'Invalid email';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password can't be empty";
    } else if (password.length < 8) {
      return 'Password must contain 8 characters';
    } else if (!(password.contains(RegExp(r'[A-Z]')))) {
      return 'Password must contain least 1 capital letter';
    } else if (!(password.contains(RegExp(r'[a-z]')))) {
      return 'Password must contain least 1 small letter';
    } else if (!(password.contains(RegExp(r'[0-9]')))) {
      return 'Password must contain least 1 numeric';
    } else if (!(password.contains(RegExp(r'''[!@#$%^&*()',.?":{}|<>]''')))) {
      return 'Password must contain least 1 special character';
    }
    return null;
  }
}