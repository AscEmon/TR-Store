
import 'dart:developer' as darttools show log;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/constant/constant_key.dart';
import '/data_provider/pref_helper.dart';
import 'package:intl/intl.dart';


extension ConvertNum on String {
  static const english = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.'
  ];
  static const bangla = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯', '.'];

  String changeNum() {
    String input = this;
    if (PrefHelper.getLanguage() == 2) {
      for (int i = 0; i < english.length; i++) {
        input = input.replaceAll(english[i], bangla[i]);
      }
    } else {
      for (int i = 0; i < english.length; i++) {
        input = input.replaceAll(bangla[i], english[i]);
      }
    }
    return input;
  }
}

extension PhoneValid on String {
  bool phoneValid(String number) {
    if (number.isNotEmpty && number.length == 11) {
      var prefix = number.substring(0, 3);
      if (prefix == "017" ||
          prefix == "016" ||
          prefix == "018" ||
          prefix == "015" ||
          prefix == "019" ||
          prefix == "013" ||
          prefix == "014") {
        return true;
      }
      return false;
    }
    return false;
  }
}

extension StringFormat on String {
  String format(List<String> args, List<dynamic> values) {
    String input = this;
    for (int i = 0; i < args.length; i++) {
      input = input.replaceAll(args[i], "${values[i]}");
    }
    return input;
  }
}

extension Context on BuildContext {
//this extention is for localization
//its a shorter version of AppLocalizations
  AppLocalizations get loc => AppLocalizations.of(this)!;

  //get media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  //get height
  double get height => MediaQuery.of(this).size.height;

  //get width
  double get width => MediaQuery.of(this).size.width;

  //Bottom Notch Check
  bool get bottomNotch =>
      MediaQuery.of(this).viewPadding.bottom > 0 ? true : false;

//Customly call a provider for read method only
//It will be helpful for us for calling the read function
//without Consumer,ConsumerWidget or ConsumerStatefulWidget
//Incase if you face any issue using this then please wrap your widget
//with consumer and then call your provider

  // T read<T>(ProviderBase<T> provider) {
  //   return ProviderScope.containerOf(this, listen: false).read(provider);
  // }
}

extension validationExtention on String {
  //Check email is valid or not
  bool get isValidEmail => RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
      .hasMatch(this);

  //check mobile number contain special character or not
  bool get isMobileNumberValid =>
      RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(this);
}

extension NumGenericExtensions<T extends String> on T {
  double parseToDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      e.log;

      return 0.0;
    }
  }

  String parseToString() {
    try {
      return this.toString();
    } catch (e) {
      e.log();

      return "";
    }
  }
}

extension VersionCheck on String {
  bool isVersionGreaterThan(String currentVersion) {
    String serverVersion = this;
    String currentV = "${currentVersion}".replaceAll(".", "");
    String serverV = "${serverVersion}".replaceAll(".", "");
    debugPrint("serverV ${serverV}");
    debugPrint("currentV ${currentV}");
    return int.parse(serverV) > int.parse(currentV);
  }
}

extension WidgetExtention on Widget {
  Widget centerCircularProgress({Color? progressColor}) => Center(
        child: Container(
          //using adaptive we can easily show platfrom base indicator
          child: CircularProgressIndicator.adaptive(
            backgroundColor: progressColor,
          ),
        ),
      );
}

extension Log on Object {
  void log() => darttools.log(toString());
}

// It will formate the date which will show in our application.
extension FormatedDateExtention on DateTime {
  String get formattedDate => DateFormat(AppConstant.MMM.key).format(this);
}

extension FormatedDateExtentionString on String {
  String formattedDate(String format) {
    DateTime parsedDate = DateTime.parse(this);
    return DateFormat(format).format(parsedDate);
  }
}

extension FormattedYearMonthDate on String? {
  DateTime fomateDateFromString({String? dateFormat}) {
    return DateFormat(dateFormat ?? AppConstant.YYYY_MM.key).parse(this ?? "");
  }
}

//This extention sum the value from List<Map<String,dynamic>>
extension StringToDoubleFoldExtention<T extends List<Map<String, dynamic>>>
    on T {
  String? get listOfMapStringSum => this
          .map((e) => double.tryParse(e.values.first?.toString() ?? ""))
          .toList()
          .fold("0", (previous, current) {
        var sum = double.parse(previous?.toString() ?? "0") +
            double.parse(current?.toString() ?? "0");
        return sum.toString().parseToDouble().toStringAsFixed(3);
      });
}

//It will capitalize the first letter of the String.
extension CapitalizeExtention on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension LastPathComponent on String {
  String get lastPathComponent => this.split('/').last.replaceAll("_", "");
}
extension IterableExtension<T> on Iterable<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var result = <T>[];
    forEach((element) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element))) {
        result.add(element);
      }
    });

    return result;
  }
}

/// it will use for finding data  from list based on same date
extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
        <K, List<E>>{},
        (Map<K, List<E>> map, E element) =>
            map..putIfAbsent(keyFunction(element), () => <E>[]).add(element),
      );
}

extension DateTimeGreater on DateTime {
  bool get isDateGreater {
    DateTime currentDate = DateTime.now();

    // Create a date to compare with the current date
    DateTime compareDate = this;
    // Example date: May 30, 2023
    if (compareDate.isAfter(currentDate)) {
      return true;
    } else {
      return false;
    }
  }
}

