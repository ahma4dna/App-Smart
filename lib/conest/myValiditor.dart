class Myvaliditor {
  static String? RequstPassowrd({String? value, String? passsword}) {
    if (value != passsword) {
      return "password to match";
    } else {
      return null;
    }
  }
}
