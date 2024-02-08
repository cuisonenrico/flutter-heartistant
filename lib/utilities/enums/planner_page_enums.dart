import 'package:flutter/material.dart';

enum TaskProgress {
  TODO(Colors.blueAccent),
  IN_PROGRESS(Colors.orangeAccent),
  COMPLETED(Colors.greenAccent);

  final Color color;

  const TaskProgress(this.color);
}

enum TimeRange { START_TIME, END_TIME }
