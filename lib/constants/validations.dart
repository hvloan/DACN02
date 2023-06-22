class Validations {
  static final passwordValidation = RegExp(
    r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)",
  );

  // static final emailValidation = RegExp(
  //   r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  // );

  static final emailValidation = RegExp(r'\S+@\S+\.\S+');

  static final phoneValidation = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  String? validateUsername(String? value) {
    return value == null || value.isEmpty ? "Username can't be empty " : null;
  }

  String? validatePasswordRegister(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 6) {
      return 'Password must be more than 6 character';
    }
    if (passwordValidation.hasMatch(value) != true) {
      return 'Password must include at least 1 character, \n 1 number, 1 capital character and 1 special character ';
    }
    return null;
  }

  String? validatePasswordLogin(String? value) {
    return value == null || value.isEmpty ? "Password can't be empty " : null;
  }

  String? validateFirstName(String? value) {
    return value == null || value.isEmpty ? "FirstName can't be empty " : null;
  }

  String? validateLastName(String? value) {
    return value == null || value.isEmpty ? "LastName can't be empty " : null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    if (emailValidation.hasMatch(value) != true) {
      return 'Email not valid! ';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    return value == null || value.isEmpty
        ? "PhoneNumber can't be empty "
        : null;
  }

  // String? validatePhoneNumber(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "PhoneNumber can't be empty";
  //   }
  //   if (phoneValidation.hasMatch(value) != true) {
  //     return 'PhoneNumber not valid!';
  //   }
  //   return "";
  // }
}
