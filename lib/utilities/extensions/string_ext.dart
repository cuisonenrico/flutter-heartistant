extension StringExt on String? {
  bool get isNullOrBlank => this == '' || this == null;
}
