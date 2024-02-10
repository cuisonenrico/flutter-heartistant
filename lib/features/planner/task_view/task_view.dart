import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_heartistant/features/planner/task_view/widgets/radio_item.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';
import 'package:flutter_heartistant/features/widgets/row_item.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:flutter_heartistant/utilities/enums/planner_page_enums.dart';
import 'package:flutter_heartistant/utilities/extensions/string_ext.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class TaskView extends StatelessWidget {
  const TaskView({
    required this.onChangeProgress,
    required this.task,
    required this.date,
    super.key,
  });

  final TaskDto? task;
  final String date;
  final ValueChanged<TaskProgress> onChangeProgress;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [FadeEffect()],
      child: AppScaffold(
        appBar: MyAppBar(
          isCornersRounded: false,
          color: TaskProgress.values[task?.progress ?? 0].color.withOpacity(0.2),
          label: 'Back',
          labelTextStyle: TextStyles.label1.copyWith(color: Colors.black),
          backIconSubstitute: Icons.arrow_back_ios_rounded,
          isMessagingIconVisible: false,
          isSecondaryIconVisible: false,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: CustomPath(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  color: TaskProgress.values[task?.progress ?? 0].color.withOpacity(0.2),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(defaultHalfPadding),
                child: Column(
                  children: [
                    Text(
                      task?.title ?? emptyString,
                      style: TextStyles.label1.copyWith(fontSize: 26.0),
                    ),
                    Text(
                      date,
                      style: TextStyles.label1.copyWith(fontSize: 26.0),
                    ),
                    const Divider(),
                    // Due
                    if (task?.time != null)
                      RowItem(
                        label: 'Due',
                        value: Text(
                          task?.time?.timeFormatted ?? emptyString,
                          style: TextStyles.body1.copyWith(color: Colors.black),
                        ),
                        icon: const Icon(Icons.alarm),
                      ),
                    RowItem(
                      label: 'Notes',
                      value: Text(
                        task?.note ?? emptyString,
                        style: TextStyles.body1.copyWith(color: Colors.black),
                      ),
                      icon: const Icon(Icons.note_sharp),
                    ),
                    RowItem(
                      label: 'Progress',
                      icon: const Icon(Icons.show_chart),
                      value: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioItem<TaskProgress>(
                            value: TaskProgress.values[task?.progress ?? 0],
                            groupValue: TaskProgress.TODO,
                            label: TaskProgress.TODO.value,
                            color: TaskProgress.TODO.color,
                            onChanged: onChangeProgress,
                          ),
                          RadioItem<TaskProgress>(
                            value: TaskProgress.values[task?.progress ?? 0],
                            groupValue: TaskProgress.IN_PROGRESS,
                            label: TaskProgress.IN_PROGRESS.value,
                            color: TaskProgress.IN_PROGRESS.color,
                            onChanged: onChangeProgress,
                          ),
                          RadioItem<TaskProgress>(
                            value: TaskProgress.values[task?.progress ?? 0],
                            groupValue: TaskProgress.COMPLETED,
                            label: TaskProgress.COMPLETED.value,
                            color: TaskProgress.COMPLETED.color,
                            onChanged: onChangeProgress,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Adjust these values to change the curvature and position of the curves
    double curveHeight1 = 200.0;
    double curveHeight2 = 380.0;

    path.moveTo(0, 0);
    path.lineTo(0, size.height - curveHeight1 - 200);
    path.quadraticBezierTo(size.width / 4, size.height - 200, size.width / 2, size.height - curveHeight1 - 200);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height - curveHeight2 - 200, size.width, size.height - curveHeight1 - 200);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
