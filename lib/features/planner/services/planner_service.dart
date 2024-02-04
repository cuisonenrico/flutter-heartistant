import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/day_plan_dto.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:flutter_heartistant/utilities/handlers/db_constants.dart';
import 'package:intl/intl.dart';

class PlannerService extends ChangeNotifier {
  CollectionReference<Map<String, dynamic>> dayPlanDb = FirebaseFirestore.instance.collection(DAY_PLAN_COLLECTION);

  Future<List<TaskDto>?> getTasks(String uid, DateTime selectedDate) async {
    final dateCreatedFormatted = DateFormat('yyyy-MM-dd').format(selectedDate);
    final primaryKey = '${uid}_$dateCreatedFormatted';

    final exists = await dayPlanDb.doc(primaryKey).get().then((value) => value.exists);

    if (!exists) return null;

    final dayPlan = await dayPlanDb.doc(primaryKey).get();

    final dayPlanDto = DayPlanDto.fromJson(dayPlan.data()!);

    if (dayPlanDto.tasks == null) return null;

    return dayPlanDto.tasks;
  }

  Future<void> createTask(String uid, DateTime dateCreated, TaskDto task) async {
    final dateCreatedFormatted = DateFormat('yyyy-MM-dd').format(dateCreated);
    final primaryKey = '${uid}_$dateCreatedFormatted';

    final exists = await dayPlanDb.doc(primaryKey).get().then((value) => value.exists);

    if (!exists) {
      final data = <String, dynamic>{
        'creationDate': dateCreatedFormatted,
        'tasks': [
          {
            'title': task.title,
            'note': task.note,
            'time': task.time,
            'progress': 0,
          },
        ]
      };
      await dayPlanDb.doc(primaryKey).set(data);
      return;
    }

    try {
      await dayPlanDb.doc(primaryKey).update({
        "tasks": FieldValue.arrayUnion([
          {
            'title': task.title,
            'note': task.note,
            'time': task.time,
            'progress': 0,
          },
        ])
      });
    } catch (e) {
      return;
    }

    return;
  }
}
