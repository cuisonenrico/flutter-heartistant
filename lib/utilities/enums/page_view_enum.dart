import 'package:flutter/material.dart';

enum PageViewList {
  ONE("One", Colors.redAccent),
  PLANNER("Planner", Colors.deepPurple),
  THREE("Three", Colors.blueAccent),
  PROFILE("Profile", Colors.white);

  final String title;
  final Color color;
  const PageViewList(this.title, this.color);
}
