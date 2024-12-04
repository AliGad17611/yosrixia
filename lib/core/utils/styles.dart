import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  static const TextStyle textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textStyle32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle textStyle40 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textStyle96 = GoogleFonts.passionOne(
    fontSize: 96,
    fontWeight: FontWeight.w700,
  );
}
