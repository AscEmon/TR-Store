import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'styles.dart';

class KTextStyle {
  static TextStyle customTextStyle(
          {double fontSize = 12, fontWeight = FontWeight.normal}) =>
      GoogleFonts.poppins(
        color: KColor.fromText.color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      );
}
