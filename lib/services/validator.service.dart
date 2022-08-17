class FormValidator {

  //For username form validation
  static String? validateName(String? value) {
    if (value!.isEmpty || value.trim().isEmpty) {
      return 'Invalid username';
    }
    return null;
  }

  //For email address form validation
  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.trim().isEmpty) {
      return 'Harap isi password dengan benar';
    }
    return null;
  }
}
