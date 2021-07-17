import 'package:get/get.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:http/http.dart' as http;

class Validations {
  static String validateemail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a valid email';
    else
      return null;
  }

  static String validateName(String value) {
    if (value.length < 2) {
      return 'Please enter a valid data';
    }
    return null;
  }

  static String validateNickName(String value) {
    if (value.length < 4) {
      return 'Please enter a valid nickName';
    }
    if (!GetUtils.isUsername(value)) {
      return 'Please enter a valid nickName';
    }
    return null;
  }

  static String validatePhone(String value) {
    if (value.length < 2) {
      return 'Phone enter is valid';
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return "Password can't be lest than 6 words";
    }
    return null;
  }

  static String validateSalary(String value) {
    if (value.length < 1) {
      return 'Salary is required';
    }
    return null;
  }
}
