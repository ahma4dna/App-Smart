class Myvalydator {
  static String? requestPassword({String? value, String? passsword}) {
    if (value != passsword) {
      return "password to match";
    } else {
      return null;
    }
  }
}
