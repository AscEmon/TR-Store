import 'package:flutter/material.dart';
import '/utils/navigation.dart';

class DateUtil {
  static DateTime? fromDate;
  static bool isToShowPreviousDate = true;
  static Future<DateTime?> showDatePickerDialog() async {
    final picked = await showDatePicker(
      context: Navigation.key.currentContext!,
      initialDate: DateTime.now(),
      //use to show the previous month
      firstDate: isToShowPreviousDate == true
          ? DateTime(2020, DateTime.december)
          : DateTime.now(),
      lastDate: DateTime.now(),
    );

    fromDate = picked;
    return picked;
  }
}

