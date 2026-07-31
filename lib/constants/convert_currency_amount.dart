import 'package:intl/intl.dart';

String formatIndianCurrency(double amount, {bool isNotSpaceAmount = false, bool singleDecimal = false, bool isNotRoundOff = false}) {
  if (amount >= 10000000) {
    if (isNotRoundOff) {
      var value = (amount / 10000000).toStringAsFixed(6);
      return "\u{20B9}${value.substring(0, value.indexOf('.') + 3)}${isNotSpaceAmount ? 'Cr' : ' Cr'}"; // Lakh
    } else {
      return "\u{20B9}${(amount / 10000000).toStringAsFixed(2)}${isNotSpaceAmount ? 'Cr' : ' Cr'}"; // Crore
    }
  } else if (amount >= 100000) {
    if (isNotRoundOff) {
      var value = (amount / 100000).toStringAsFixed(6);
      return "\u{20B9}${value.substring(0, value.indexOf('.') + 3)}${isNotSpaceAmount ? 'L' : ' L'}"; // Lakh
    } else {
      return "\u{20B9}${(amount / 100000).toStringAsFixed(2)}${isNotSpaceAmount ? 'L' : ' L'}"; // Lakh
    }
  }
  if (amount >= 10000) {
    if (isNotRoundOff) {
      var value = (amount / 1000).toStringAsFixed(6);
      return "\u{20B9}${value.substring(0, value.indexOf('.') + 2)}${isNotSpaceAmount ? 'K' : 'K'}"; // Lakh
    } else {
      return "\u{20B9}${(amount / 1000).toStringAsFixed(singleDecimal == false ? 2 : 1)}${isNotSpaceAmount ? 'K' : 'K'}"; // Lakh
    }
  } else {
    if (singleDecimal == true) {
      if (amount >= 1000 && amount < 10000) {
        return "\u{20B9}${amount.toStringAsFixed(1)}"; // Lakh
      }
    }
    return "\u{20B9}${amount.toStringAsFixed(2)}"; // Less than 1 lakh, show the full amount
  }
}

String formatIndianCurrencyFormat(double amount) {
  var formatter = NumberFormat('#,###');
  if (amount >= 10000000.00) {
    var amtCr = formatter.format((amount / 10000000.00));
    return "₹$amtCr Cr"; // Crore
  } else if (amount >= 100000.00) {
    var amtL = formatter.format((amount / 100000.00));
    return "₹$amtL L"; // Lakh
  }
  if (amount >= 10000.00) {
    var amtK = formatter.format((amount / 1000.00));

    return "₹$amtK" ' k'; // Lakh
  } else {
    return "\u{20B9}${amount.toStringAsFixed(2)}"; // Less than 1 lakh, show the full amount
  }
}

String rupeeSymbol() {
  return '\u{20B9}';
}

String convertAmountComma(double amount, {bool isDecimal = true, bool isBubble = false}) {
  final indianFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹', // You can change or remove the currency symbol
    decimalDigits: isBubble
        ? amount < 1000
            ? 0
            : amount < 100000
                ? 1
                : 2
        : isDecimal
            ? 2
            : 0,
  );
  return indianFormat.format(amount);
}

String amountWithComma(double amount, {int decimalDig = 0, bool isRemoveSymbol = false}) {
  final indianFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: isRemoveSymbol ? '' : '₹', // You can change or remove the currency symbol
    decimalDigits: decimalDig,
  );
  return indianFormat.format(amount);
}

String toTitleCase(String text) {
  if (text.isEmpty) {
    return text;
  }

  return text.split(' ').map((word) {
    if (word.isEmpty) {
      return word;
    }
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

String tenureFormat(String value) {
  var check = value.replaceAll("0 Y", "").replaceAll("0Y", "");
  return check.trim();
}

String removeCategoryNA(String value) {
  var check = value.replaceAll("N/A", "").replaceAll(" N/A", "").replaceAll("N/ A", "");
  return check.trim().toUpperCase();
}
String removePsu(String value){
  var check = value.replaceAll("Public Sector Undertaking", "");
  return check.trim().toUpperCase();
}

String sectorCategory(String value) {
  if (value.toLowerCase() == 'cb') {
    return 'CORP';
  } else {
    return value;
  }
}

String maxCharacterName({required String value, int maxCharacter = 21}) {
  if(value.length > 1){
    List<String> words = value.split(' ');
    int spaceCount = words.length - 1;
   maxCharacter=maxCharacter+spaceCount;

  }
  String displayText = value.length > maxCharacter ? value.substring(0, maxCharacter) : value;
  return displayText;
}
