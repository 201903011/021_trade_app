import 'package:minimals/config/config_data.dart';
import 'package:minimals/config/models/app_config.dart';
import 'package:flutter/foundation.dart'; // for kDebugMode
import 'package:intl/intl.dart'; // for DateFormat

// Export for easier access
export 'package:minimals/config/models/app_config.dart' show Environment;

import 'dart:math';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

/// Global application configuration instance
/// This can be switched between different environments (dev, uat, prod)
late AppConfig appConfig;

/// Initialize the global app configuration
/// Call this early in the app lifecycle (preferably in main())
void initializeAppConfig({AppConfig? config}) {
  appConfig = config ?? devDefaultConfig;
}

/// Get the current app configuration
AppConfig getAppConfig() => appConfig;

/// Set app configuration for specific environment
void setAppConfigForEnvironment(Environment environment) {
  switch (environment) {
    case Environment.development:
      appConfig = devDefaultConfig;
      break;
    case Environment.staging:
      appConfig = uatDefaultConfig;
      break;
    case Environment.production:
      appConfig = prodDefaultConfig;
      break;
  }
}

// Utility functions for date formatting and manipulation
String addLeadingZero(String value) {
  return value.toString().padLeft(2, '0');
}

/// Get the short month name (first three letters) from a full month name
String getShortMonth(String monthName) {
  if (monthName.length < 3) {
    return monthName.toUpperCase();
  }
  return monthName.substring(0, 3).toUpperCase();
}

String? convertDate(DateTime? date) {
  if (date == null) {
    return null;
  }
  final convertedDateFormat = DateFormat('dd-MMM-yyyy');
  return convertedDateFormat.format(date);
}

String? convertDateSpace(DateTime? date) {
  if (date == null) {
    return null;
  }
  final convertedDateFormat = DateFormat('dd MMM yy');
  return convertedDateFormat.format(date);
}

String convertTimestampToDateString(int timestamp, {bool is10yearAdd = false, bool isNse = false}) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  if (is10yearAdd) {
    int currentYear = DateTime.now().year;
    date = DateTime(currentYear, date.month, date.day - (isNse ? 1 : 0), date.hour, date.minute, date.second);
    date = date;
  }
  String formattedDate = DateFormat('dd MMM yyyy').format(date);
  return formattedDate;
}

String convertTimestampToString(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
  String formattedDate = DateFormat('HH:mm:ss').format(date);
  return formattedDate;
}

int calculateAge(DateTime birthDate) {
  DateTime today = DateTime.now();

  // Calculate the difference in years
  int age = today.year - birthDate.year;

  // If birth date is not yet reached this year, subtract 1 from age
  if (birthDate.isAfter(DateTime(today.year, today.month, today.day))) {
    age--;
  }

  return age;
}

String? convertDate1(DateTime? date) {
  if (date == null) {
    return 'Date of Birth is required';
  }
  final convertedDateFormat = DateFormat('dd/MMM/yyyy');
  return convertedDateFormat.format(date);
}

DateTime? getDate(String dateString) {
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  DateTime? date = dateFormat.tryParse(dateString);
  return date;
}

String generateRequestId() {
  Random random = Random();
  String randomNumber = '';
  randomNumber += (random.nextInt(9) + 1).toString();
  for (int i = 0; i < 9; i++) {
    randomNumber += random.nextInt(10).toString();
  }
  return randomNumber;
}

String capitalizeEachWord(String input) {
  if (input.isEmpty) return input;
  List<String> words = input.split(' ');
  List<String> capitalizedWords = words.map((word) {
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).toList();
  return capitalizedWords.join(' ');
}

String maskPanNumber(String text) {
  if (text.length <= 4) return text;
  return '*****${text.substring(text.length - 4)}';
}

String maskAadharNumber(String text) {
  if (text.length <= 4) return text;
  return '**** **** ${text.substring(text.length - 4)}';
}

String maskAccNumber(String text) {
  if (text.length <= 4) return text;
  return '**********${text.substring(text.length - 4)}';
}

String addSpaceAfterComma(String input) {
  return input.replaceAll(',', ', ');
}

String getGender(String gender) {
  if (gender == 'M') {
    return 'Male';
  } else if (gender == 'F') {
    return 'Female';
  } else if (gender == 'O') {
    return 'Others';
  } else {
    return gender;
  }
}

String getResidential(String status) {
  if (status == 'R') {
    return 'Resident';
  } else {
    return status;
  }
}

String getCapitalLetter(String input) {
  return input.toUpperCase();
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('d MMMM y');
  return formatter.format(date);
}

DateTime getEighteenYearsBackDate() {
  DateTime now = DateTime.now();
  DateTime eighteenYearsBack = DateTime(now.year - 18, now.month, now.day);
  return eighteenYearsBack;
}

DateTime getDate101YearsBack() {
  DateTime now = DateTime.now();
  DateTime date101YearsBack = DateTime(now.year - 101, now.month, now.day);
  return date101YearsBack;
}

Future<String> getSmsAutoFillSignature() async {
  String signature = await SmsAutoFill().getAppSignature;
  return signature;
}

String formatName(String fullName) {
  List<String> nameParts = fullName.trim().split(' ');
  if (nameParts.length > 2) {
    nameParts = [nameParts.first, nameParts.last];
  }
  String formattedFirstName = nameParts[0][0].toUpperCase() + nameParts[0].substring(1).toLowerCase();
  String formattedLastName = nameParts[1][0].toUpperCase() + nameParts[1].substring(1).toLowerCase();
  return '$formattedFirstName $formattedLastName';
}

DateTime? convertToDateTime(String dateString) {
  try {
    // Define all supported date formats
    DateFormat dateFormat1 = DateFormat("dd-MMM-yyyy");
    DateFormat dateFormat2 = DateFormat("dd/MM/yyyy");
    DateFormat dateFormat3 = DateFormat("yyyy-MM-dd"); // Add support for this format

    try {
      return dateFormat1.parse(dateString); // Try "dd-MMM-yyyy"
    } catch (e) {
      try {
        return dateFormat2.parse(dateString); // Try "dd/MM/yyyy"
      } catch (e) {
        return dateFormat3.parse(dateString); // Try "yyyy-MM-dd"
      }
    }
  } catch (e) {
    debugPrint("Error parsing date: $e");
    return null;
  }
}

String showRandomMessage() {
  var messages = [
    "In India, the bond market is approximately half of the stock market, unlike in developed economies where it is typically 2 to 3 times larger.",
    "The annual issuance for Corporate Bonds in India for FY’24 is ₹8.6 Lakh Crores.",
    "You can earn more on bonds than FDs, RDs/ traditional fixed income instruments.",
    "Bonds in India can provide returns ranging from 7% to 17% and can be traded with maturity ranging from 1 month to 50 Years.",
    "The Price & the Yield of a Bond are inversely proportional to each other.",
    "The first-ever SGB issued by the RBI, yielded a 128% return with an 11% CAGR and was entirely tax-free.",
    "Tax-free bonds issued by public sector enterprises offer attractive returns, generally between 6%-7% post tax.",
    "54-EC Bonds are popular for offering tax exemption on LTCG of up to Rs. 50 lakh per year specifically.",
    "You can start investing in bonds with just ₹100 on NSE/BSE.",
    "You can protect yourself from inflation by purchasing bonds that are linked to inflation.",
    "Zero coupon bonds work like cumulative Fixed Deposits paying the entire interest on maturity.",
    "18,000 listed bonds are available on Indian stock exchanges, including government, corporate, and municipal bonds.",
    "Bonds can provide regular income, liquidity without penalties, and tax savings on capital gains, unlike fixed deposits.",
    "Bonds are rated by SEBI accredited credit agencies like Crisil, ICRA, India Rating & CARE.",
    "Government bonds are deemed safer due to government backing, resulting in lower interest rates compared to corporate bonds.",
    "Short-term bonds provide lower risk and more stable returns than long-term bonds.",
    "The COVID-19 pandemic led to a ~20% rise in individual investments in both Government bonds and Corporate bonds."
  ];

  var random = Random();
  int randomIndex = random.nextInt(messages.length);
  debugPrint(messages[randomIndex]);
  return messages[randomIndex];
}

String maskPhoneNumber(String phoneNumber) {
  if (phoneNumber.length != 10) {
    return phoneNumber;
  }
  return phoneNumber.replaceRange(2, 6, '****');
}

String maskEmail(String email) {
  int atIndex = email.indexOf('@');
  if (atIndex <= 1) {
    return email;
  }
  String namePart = email.substring(0, atIndex);
  String domainPart = email.substring(atIndex);

  if (namePart.length <= 4) {
    return email;
  }
  String maskedName = namePart.replaceRange(2, namePart.length - 2, '****');
  return maskedName + domainPart;
}

bool isUnderage(String dateString) {
  try {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime birthDate = dateFormat.parse(dateString);
    DateTime currentDate = DateTime.now();
    DateTime cutoffDate = DateTime(
      currentDate.year - 18,
      currentDate.month,
      currentDate.day,
    );
    if (birthDate.isAfter(cutoffDate)) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    debugPrint("Error parsing date: $e");
    return false;
  }
}

String getFirstName(String fullName) {
  List<String> nameParts = fullName.split(' ');
  return nameParts.isNotEmpty ? nameParts[0] : '';
}

String formatIndianNumber(String number) {
  double value = double.parse(number);
  final formatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '',
    decimalDigits: 2,
  );
  return formatter.format(value).trim();
}

String formatNumberWithTwoDecimals(String value) {
  double number = double.tryParse(value) ?? 0.0;
  // final NumberFormat formatter = NumberFormat('0.00');
  final NumberFormat formatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹', // You can change or remove the currency symbol
    decimalDigits: 2,
  );
  return formatter.format(number);
}

String formatFundsDate(String dateString) {
  DateTime parsedDate = DateTime.parse(dateString);
  String formattedDate = DateFormat('dd MMM yy').format(parsedDate);
  return formattedDate;
}

String formatTimeToAmPm(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedTime = DateFormat('h:mm:ss a').format(dateTime);
  return formattedTime;
}

String? getIdByType(String searchString) {
  List<Map<String, String>> records = _getRecords();
  for (var record in records) {
    if (record['type']?.toLowerCase() == searchString.toLowerCase()) {
      return record['id'];
    }
  }

  return null;
}

String? getTypeById(String id) {
  List<Map<String, String>> records = _getRecords();
  for (var record in records) {
    if (record['id'] == id) {
      return record['type'];
    }
  }

  return null;
}

String getCurrentTimeWithAmPmAndSeconds({bool isOnlyTime = false}) {
  final now = DateTime.now();
  final formattedTime = isOnlyTime ? DateFormat('hh:mm:ss a').format(now).toLowerCase() : DateFormat('yyyy-MM-dd hh:mm:ss a').format(now).toLowerCase();
  return formattedTime;
}

List<Map<String, String>> _getRecords() {
  return [
    {'id': '1', 'type': 'PAN'},
    {'id': '2', 'type': 'Aadhaar Card'},
    {'id': '3', 'type': 'Driving Licence'},
    {'id': '4', 'type': 'Passport'},
    {'id': '5', 'type': 'Voter ID'},
    {'id': '6', 'type': 'Cheque'},
    {'id': '7', 'type': 'Vehicle RC'},
    {'id': '8', 'type': 'CKYC'},
    {'id': '9', 'type': 'Esign'},
    {'id': '10', 'type': 'Selfie'},
    {'id': '11', 'type': 'Masked Aadhaar'},
    {'id': '12', 'type': 'Rent Agreement'},
    {'id': '13', 'type': 'POA Common'},
    {'id': '14', 'type': 'Signature'},
    {'id': '15', 'type': 'Digilocker - Zip'},
    {'id': '16', 'type': 'Digilocker - PAN'},
    {'id': '17', 'type': 'Digilocker - AADHAAR'},
    {'id': '18', 'type': 'Demat - CMR'},
  ];
}

int generateRandom10DigitNumber() {
  Random random = Random();
  int firstPart = random.nextInt(9) + 1;
  int remainingPart = random.nextInt(1000000000);
  int randomNumber = firstPart * 1000000000 + remainingPart;
  return randomNumber;
}

String intToMonth(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "Jan";
  }
}

String convertDurationString(String durationString) {
  // Splitting the string into parts
  List<String> parts = durationString.split(' ');

  // Mapping the shorthand notation to full form
  Map<String, String> mappings = {
    'Y': 'Year',
    'M': 'Month',
  };

  // Initializing an empty list to store the final parts
  List<String> finalParts = [];

  // Iterate through the parts in pairs (value, unit), ensuring the index exists
  for (int i = 0; i < parts.length; i += 2) {
    String value = parts[i];
    String unit = i + 1 < parts.length ? parts[i + 1] : '';

    // Skip if value is '0' (for both year and month)
    if (value == '0') continue;

    // Map the unit to full form (Year/Month), handle pluralization
    String fullUnit = mappings[unit] ?? '';
    if ((int.tryParse(value) ?? 0) > 1) {
      fullUnit += 's';
    }

    finalParts.add('$value $fullUnit');
  }

  // Joining the final parts or return an empty string if nothing valid
  return finalParts.isNotEmpty ? finalParts.join(' ') : '';
}

String convertMonthsToYearsAndMonths(int totalMonths) {
  int years = totalMonths ~/ 12; // Calculate full years
  int months = totalMonths % 12; // Calculate remaining months

  // Initialize the final parts list
  List<String> finalParts = [];

  // Add the years part if it's greater than 0
  if (years > 0) {
    finalParts.add('$years ${years == 1 ? 'Y' : 'Y'}');
  }

  // Add the months part if it's greater than 0
  if (months > 0) {
    finalParts.add('$months ${months == 1 ? 'M' : 'M'}');
  }

  // Join the final parts with a space
  return finalParts.join(' ');
}

String convertFormat(String tenure) {
  if (tenure == "") {
    return "-";
  }
  int ten = int.tryParse(tenure.trim()) ?? -1;
  if (ten >= 0) {
    return convertMonthsToYearsAndMonths(ten);
  } else {
    return convertDurationString(tenure);
  }
}

String formatNumber(String value, {bool returnSame = false}) {
  if (returnSame) return value;
  if (value.isEmpty) return '';
  final formatter = NumberFormat('#,###');
  return formatter.format(int.parse(value));
}

String formatNumberDecimal(String value, {bool returnSame = false}) {
  if (returnSame) return value;
  if (value.isEmpty) return '';
  final NumberFormat formatter = NumberFormat("#,##0.00");
  return formatter.format(int.parse(value));
}

String getNumberCommaSep(String input) {
  // Remove all commas using replaceAll method
  String result = input.replaceAll(',', '');
  return result;
}

String convertToYMD(String? y, String? m, String? d) {
  List<String> result = [];

  if (y?.startsWith("0") == false) result.add(y ?? "");
  if (m?.startsWith("0") == false) result.add(m ?? "");
  if (d?.startsWith("0") == false) result.add(d ?? "");

  return result.join(" ");
}

String convertToYMDString(String tenure, {isReturnSame = false}) {
  // if(isReturnSame){
  //   return tenure;
  // }
  int ten = int.tryParse(tenure.trim()) ?? -1;
  if (ten >= 0) {
    return convertMonthsToYearsAndMonths(ten);
  } else {
    // return tenureFormat(tenure);
    List<String> splitArray = tenure.trim().split(" ");

    return convertToYMD(splitArray.firstWhereOrNull((el) => el.toUpperCase().contains("Y")), splitArray.firstWhereOrNull((el) => el.toUpperCase().contains("M")),
        splitArray.firstWhereOrNull((el) => el.toUpperCase().contains("D")));
  }
}

String addNewlineAfter16(String text) {
  const maxLength = 18;
  StringBuffer buffer = StringBuffer();
  int lineLength = 0;

  text.split(' ').forEach((word) {
    if (lineLength + word.length > maxLength) {
      buffer.write('\n');
      lineLength = 0;
    }
    buffer.write('$word ');
    lineLength += word.length + 1; // add 1 for space
  });

  return buffer.toString().trim();
}

String reformatDate(String merchTxnDate) {
  merchTxnDate = merchTxnDate.replaceAll(' ', '');
  DateTime parsedDate = DateFormat("yyyy-MM-ddHH:mm:ss").parse(merchTxnDate);
  return DateFormat("yyyy-MM-dd HH:mm:ss").format(parsedDate);
}

String formatFileSize(int bytes) {
  if (bytes < 1024) {
    return "$bytes B"; // Bytes
  } else if (bytes < 1024 * 1024) {
    return "${(bytes / 1024).toStringAsFixed(2)} KB"; // Kilobytes
  } else if (bytes < 1024 * 1024 * 1024) {
    return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB"; // Megabytes
  } else {
    return "${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB"; // Gigabytes
  }
}

double calculatePrice(String? cleanPrice, String? faceValue) {
  final parsedCleanPrice = double.tryParse(cleanPrice ?? "0") ?? 0.0;
  final parsedFaceValue = double.tryParse(faceValue ?? "1") ?? 1.0;
  if (parsedFaceValue == 0) {
    return 0.0;
  }
  return (parsedCleanPrice * 100) / parsedFaceValue;
}
