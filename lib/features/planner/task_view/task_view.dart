import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  static const route = 'task-view';
  static const routeName = 'task-view';

  @override
  Widget build(BuildContext context) {
    // TODO: make UI for TaskView
    return AppScaffold(
      body: Container(
        color: Colors.pink,
      ),
    );
  }
}
