import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

// String? emailValidator(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Please enter your email';
//   }
//   String pattern = r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
//   RegExp regex = RegExp(pattern);
//   if (!regex.hasMatch(value)) {
//     return 'Please enter a valid email address';
//   }
//   return null;
// }

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? nomineeEmailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter nominee email';
  }
  String pattern = r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your name';
  }
  return null;
}

String? validatePassword(String? value, String? loginId) {
  final password = value ?? '';

  debugPrint('Password input: "$password"');

  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#^])[A-Za-z\d@$!%*?&#^]{6,12}$',
  );

  if (password.isEmpty) {
    debugPrint('Failure: Password is empty');
    return 'Please enter your Password to proceed.';
  }

  if (!passwordRegExp.hasMatch(password)) {
    debugPrint('Failure: Password regex check failed');
    return 'Password must be 6-12 characters long and include at least one lowercase letter, one uppercase letter, one digit, and one special character';
  }

  if (password == loginId) {
    debugPrint('Failure: Password is the same as login ID');
    return 'Password must not be the same as login ID';
  }
  debugPrint('Success: Password validation passed');
  return null;
}

String? validateCRMPanCard(String? value) {
  final panCardNumber = value?.toUpperCase() ?? '';
  final RegExp panPattern = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

  if (panCardNumber.isEmpty) {
    return 'Minimum 1 PAN of other holders is required';
  }
  if (!panPattern.hasMatch(panCardNumber)) {
    return 'PAN card number must be 10 characters long, starting with 5 uppercase letters, followed by 4 digits, and ending with 1 uppercase letter';
  }
  return null;
}

String? validatePanCard(String? value) {
  final panCardNumber = value?.toUpperCase() ?? '';
  final RegExp panPattern = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

  if (panCardNumber.isEmpty) {
    return 'Please enter your PAN to proceed.';
  }
  if (!panPattern.hasMatch(panCardNumber)) {
    return 'PAN card number must be 10 characters long, starting with 5 uppercase letters, followed by 4 digits, and ending with 1 uppercase letter';
  }
  return null;
}

String? nomineeValidatePanCard(String? value) {
  final panCardNumber = value?.toUpperCase() ?? '';
  final RegExp panPattern = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');

  if (panCardNumber.isEmpty) {
    return 'Please enter nominee PAN to proceed.';
  }
  if (!panPattern.hasMatch(panCardNumber)) {
    return 'PAN card number must be 10 characters long, starting with 5 uppercase letters, followed by 4 digits, and ending with 1 uppercase letter';
  }
  return null;
}

String? validateUserId(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter User ID to proceed.';
  }

  // Regular expression to allow only alphanumeric characters
  final RegExp regExp = RegExp(r'^[a-zA-Z0-9]+$');

  if (!regExp.hasMatch(value)) {
    return 'User ID should not contain special characters';
  }

  return null;
}

String? validateDate(String? value) {
  final dateString = value ?? '';
  final RegExp datePattern = RegExp(r'^\d{2}-[A-Za-z]{3}-\d{4}$');

  if (dateString.isEmpty) {
    return 'Date of Birth is required';
  }

  // Check if the format matches the pattern
  if (!datePattern.hasMatch(dateString)) {
    return 'Date of Birth must be in the format dd-MMM-yyyy';
  }

  try {
    // Parse the date to ensure it's a valid date
    final dateFormat = DateFormat('dd-MMM-yyyy');
    final date = dateFormat.parse(dateString);

    // Optional: Check if the date is in the future
    if (date.isAfter(DateTime.now())) {
      return 'Date of Birth cannot be in the future';
    }
  } catch (e) {
    return 'Date of Birth is not a valid date';
  }

  return null;
}

String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your mobile number to proceed';
  }
  String pattern = r'^[6-9]\d{9}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid mobile number';
  }
  return null;
}

String? nomineePhoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter nominee mobile number to proceed';
  }
  String pattern = r'^[6-9]\d{9}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid mobile number';
  }
  return null;
}

bool validateEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[\w-\.+-]+@([\w-]+\.)+[\w-]{1,6}$',
    caseSensitive: false,
    multiLine: false,
  );
  return emailRegex.hasMatch(email);
}

bool isValidUPIID(String upiID) {
  final upiRegex = RegExp(r'^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$');
  return upiRegex.hasMatch(upiID);
}

String? emptyState(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your mobile number to proceed';
  }
  // String pattern = r'^[6-9]\d{9}$';
  // RegExp regex = RegExp(pattern);
  // if (!regex.hasMatch(value)) {
  //   return 'Please enter a valid mobile number';
  // }
  return null;
}
