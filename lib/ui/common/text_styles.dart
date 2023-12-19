import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wireguard_flutter/ui/common/colors.dart';

class TextStyles {
  ///Arial
  static const TextStyle regular14 = TextStyle(
    fontFamily: 'Arial',
    fontSize: 14,
    color: Colors.white,
  );
  static const TextStyle regular16 = TextStyle(
    fontFamily: 'Arial',
    fontSize: 16,
    color: Colors.white,
  );
  static const TextStyle redTitle = TextStyle(
    fontFamily: 'Arial',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: PjColors.red,
  );
  static const TextStyle italic12 = TextStyle(
    fontFamily: 'Arial',
    fontSize: 12,
    color: Colors.white,
    fontStyle: FontStyle.italic,
  );

  ///PF BeauSans Pro
  static const TextStyle beauSansRegular14 = TextStyle(
    fontFamily: 'PF BeauSans Pro',
    fontSize: 14,
    color: PjColors.lightGrey,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle beauSansBold16 = TextStyle(
      fontFamily: 'PF BeauSans Pro',
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white);
}
