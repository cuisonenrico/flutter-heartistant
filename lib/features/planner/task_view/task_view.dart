import 'package:flutter/material.dart';
import 'package:flutter_heartistant/features/planner/task_view/widgets/radio_item.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/app_bar.dart';
import 'package:flutter_heartistant/features/widgets/app_scaffold.dart';
import 'package:flutter_heartistant/features/widgets/row_item.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:flutter_heartistant/utilities/enums/page_view_enum.dart';
import 'package:flutter_heartistant/utilities/enums/planner_page_enums.dart';
import 'package:flutter_heartistant/utilities/extensions/string_ext.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';

class TaskView extends StatelessWidget {
  const TaskView({
    required this.onChangeProgress,
    required this.task,
    super.key,
  });

  final TaskDto? task;
  final ValueChanged<TaskProgress> onChangeProgress;

  @override
  Widget build(BuildContext context) {
    // TODO: make UI for TaskView

    return AppScaffold(
      appBar: const MyAppBar(
        label: emptyString,
        isMessagingIconVisible: false,
        isSecondaryIconVisible: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultHalfPadding),
        child: Column(
          children: [
            Text(
              task?.title ?? emptyString,
              style: TextStyles.label1.copyWith(fontSize: 26.0),
            ),
            const Divider(),
            // Due
            if (task?.time != emptyString)
              RowItem(
                label: 'Due',
                value: Text(task?.time?.timeFormatted ?? emptyString),
                icon: const Icon(Icons.alarm),
              ),
            RowItem(
              label: 'Notes',
              value: Text(task?.note ?? emptyString),
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
                    color: PageViewList.PLANNER.color,
                    onChanged: onChangeProgress,
                  ),
                  RadioItem<TaskProgress>(
                    value: TaskProgress.values[task?.progress ?? 0],
                    groupValue: TaskProgress.IN_PROGRESS,
                    label: TaskProgress.IN_PROGRESS.value,
                    color: PageViewList.PLANNER.color,
                    onChanged: onChangeProgress,
                  ),
                  RadioItem<TaskProgress>(
                    value: TaskProgress.values[task?.progress ?? 0],
                    groupValue: TaskProgress.COMPLETED,
                    label: TaskProgress.COMPLETED.value,
                    color: PageViewList.PLANNER.color,
                    onChanged: onChangeProgress,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
