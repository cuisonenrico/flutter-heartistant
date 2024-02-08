import 'package:flutter/material.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension SvgExt on String {
  Widget get svg => SvgPicture.asset(
        this,
        width: 10.0,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      );
}

extension TimeExt on String {
  String? get timeFormatted => contains('null') ? replaceAll('null', emptyString).replaceAll(' - ', emptyString) : this;
}
