class CheckEmail {
  bool isValid = false;
  getCheckEmail(String value) {
    isValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    return isValid;
  }
}
