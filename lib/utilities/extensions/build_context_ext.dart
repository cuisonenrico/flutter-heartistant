import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get mediaSize => mediaQuery.size;

  double get height => mediaSize.height;

  double get width => mediaSize.width;

  double widthPercentage(double multiplier) => width * multiplier;

  double heightPercentage(double multiplier) => height * multiplier;
}
