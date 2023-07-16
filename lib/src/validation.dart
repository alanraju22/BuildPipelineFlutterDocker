

class Validation {


 String isLogin(String email) {
    if (!RegExp(r'^[a-zA-Z0-9]+').hasMatch(email)) {
      return ' Invalid Mail Id or it should contain all type of chars ';
    }
    return email;
  }

  String isPassword(String password)  {
    if (!RegExp((r'\d')).hasMatch(password)) {
      return 'password should contain digits';
    }
    return password;
  }

}


