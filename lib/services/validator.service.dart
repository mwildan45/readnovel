import 'package:basic_utils/basic_utils.dart';

class FormValidator {

  //For username form validation
  static String? validateName(String? value) {
    if (value!.isEmpty || value.trim().isEmpty) {
      return 'Harap isi username dengan benar';
    }
    return null;
  }

  //For email address form validation
  static String? validateEmail(String? value) {
    if (value!.isEmpty || !EmailUtils.isEmail(value)) {
      return 'Harap isi email dengan benar';
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
