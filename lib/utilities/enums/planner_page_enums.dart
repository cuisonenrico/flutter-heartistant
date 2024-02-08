import 'package:flutter/material.dart';

enum TaskProgress {
  TODO(Colors.blue, 'Todo'),
  IN_PROGRESS(Colors.orangeAccent, 'In Progress'),
  COMPLETED(Colors.greenAccent, 'Completed');

  final Color color;
  final String value;

  const TaskProgress(this.color, this.value);
}

enum TimeRange { START_TIME, END_TIME }
