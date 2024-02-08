import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_heartistant/features/planner/task_view/task_view.dart';
import 'package:flutter_heartistant/features/styles/spacers.dart';
import 'package:flutter_heartistant/features/styles/styles.dart';
import 'package:flutter_heartistant/features/widgets/floating_container.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:flutter_heartistant/utilities/decorations.dart';
import 'package:flutter_heartistant/utilities/enums/planner_page_enums.dart';
import 'package:flutter_heartistant/utilities/string_constants.dart';
import 'package:flutter_heartistant/utilities/widget_constants.dart';
import 'package:go_router/go_router.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    required this.tasks,
    required this.onSelectTask,
    super.key,
  });

  final List<TaskDto> tasks;
  final ValueChanged<int> onSelectTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(defaultRadius)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(6, 0),
          ),
        ],
      ),
      child: Animate(
        effects: const [
          SlideEffect(
            duration: Duration(milliseconds: 300),
            end: Offset(0, 0),
            begin: Offset(0, 1),
          )
        ],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(defaultSpacing),
              if (tasks.isNotEmpty)
                ...tasks.mapIndexed(
                  (index, task) => InkWell(
                    onTap: () {
                      onSelectTask(index);
                      context.pushNamed(TaskView.routeName);
                    },
                    child: FloatingContainer(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [defaultShadow],
                        border: Border(
                          left: BorderSide(
                            width: 8.0,
                            color: TaskProgress.values[task.progress ?? 0].color,
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultQuarterPadding,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultHalfPadding,
                        vertical: defaultHalfPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                task.title ?? emptyString,
                                style: TextStyles.label1,
                              ),
                              Text(
                                task.time ?? emptyString,
                                style: TextStyles.label1,
                              ),
                            ],
                          ),
                          const VerticalSpace(defaultQuarterSpacing),
                          Text(
                            task.note ?? emptyString,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.body2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
