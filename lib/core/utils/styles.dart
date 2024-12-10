import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yosrixia/core/utils/constants.dart';

abstract class Styles {
  static TextStyle textStyle20 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyle24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyle32 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
    color: kPrimaryColor,
  );

  static TextStyle textStyle40 = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyle40Passion = GoogleFonts.passionOne(
    fontSize: 40.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyle64Passion = GoogleFonts.passionOne(
    fontSize: 64.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyle96 = GoogleFonts.passionOne(
    fontSize: 96.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle textStyle128Passion = GoogleFonts.passionOne(
    fontSize: 128.sp,
    fontWeight: FontWeight.w400,
  );
}
