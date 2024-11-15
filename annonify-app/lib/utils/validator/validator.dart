class Validator {
  static String? validateEmptyText(String? fieldname, String? value) {
    if (value == null || value.isEmpty) {
      return "$fieldname is required";
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email is required";
    }

    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!regex.hasMatch(email)) {
      return "Email is invalid";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password is required";
    }

    if (password.length < 6) {
      return "Password is too short";
    }

    return null;
  }
}
