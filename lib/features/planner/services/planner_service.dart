import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/day_plan_dto.dart';
import 'package:flutter_heartistant/state/planner_page_state/models/task_dto.dart';
import 'package:flutter_heartistant/utilities/extensions/time_format_ext.dart';
import 'package:flutter_heartistant/utilities/handlers/db_constants.dart';

class PlannerService extends ChangeNotifier {
  PlannerService();

  CollectionReference<Map<String, dynamic>> dayPlanDb = FirebaseFirestore.instance.collection(DAY_PLAN_COLLECTION);

  Future<List<TaskDto>?> getTasks(String uid, DateTime selectedDate) async {
    final dateCreatedFormatted = selectedDate.toDateFormatted;
    final primaryKey = '${uid}_$dateCreatedFormatted';

    final exists = await dayPlanDb.doc(primaryKey).get().then((value) => value.exists);

    if (!exists) return null;

    final dayPlan = await dayPlanDb.doc(primaryKey).get();

    final dayPlanDto = DayPlanDto.fromJson(dayPlan.data()!);

    if (dayPlanDto.tasks == null) return null;

    return dayPlanDto.tasks;
  }

  Future<void> createTask(String uid, DateTime dateCreated, TaskDto task) async {
    final dateCreatedFormatted = dateCreated.toDateFormatted;
    final primaryKey = '${uid}_$dateCreatedFormatted';

    final exists = await dayPlanDb.doc(primaryKey).get().then((value) => value.exists);

    if (!exists) {
      final data = <String, dynamic>{
        'creationDate': dateCreatedFormatted,
        'tasks': [task.toJson()]
      };
      await dayPlanDb.doc(primaryKey).set(data);
      return;
    }

    try {
      await dayPlanDb.doc(primaryKey).update({
        "tasks": FieldValue.arrayUnion([task.toJson()])
      });
    } catch (e) {
      return;
    }

    return;
  }

  Future<void> updateProgress(String id, List<TaskDto> tasks) async {
    final tasksMapped = tasks.map((task) => task.toJson());
    await dayPlanDb.doc(id).update({"tasks": tasksMapped});
    return;
  }
}
