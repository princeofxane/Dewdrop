import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../models/bt_device.dart';

enum Days {
  sun,
  mon,
  tue,
  wed,
  thu,
  fri,
  sat
}

enum PeriodTypes {
  daily,
  alternative,
  custom
}

enum FrequencyTypes {
  everyHour,
  everyTwoHour,
  everyFourHour
}

enum CreationTypes {
  preset,
  userCreated
}

class CustomTimeAndDuration {
  final DateTime time;
  final int duration;

  CustomTimeAndDuration(
    this.time,
    this.duration
  );
}

class Schedule {
  final String id;
  final String name;
  final int? duration;
  final CreationTypes creationType;
  final PeriodTypes periodTypes;
  final FrequencyTypes frequencyTypes;
  final List<CustomTimeAndDuration>? customTimeDurationList;
  final List<Days>? selectedDays;

  Schedule({
    required this.id,
    required this.name,
    this.duration,
    required this.creationType,
    required this.periodTypes,
    required this.frequencyTypes,
    this.customTimeDurationList,
    this.selectedDays
  });
}


class Schedules with ChangeNotifier{
  List<Schedule> schedules = [
    Schedule(
      id: 'cd12',
      name: 'Every day two hours',
      duration: 10,
      creationType: CreationTypes.preset,
      periodTypes: PeriodTypes.daily,
      frequencyTypes: FrequencyTypes.everyTwoHour
    ),
    Schedule(
        id: 'cd13',
        name: 'Alternative and two hours',
        duration: 10,
        creationType: CreationTypes.userCreated,
        periodTypes: PeriodTypes.alternative,
        frequencyTypes: FrequencyTypes.everyHour
    ),
    Schedule(
        id: 'cd14',
        name: 'Custom days with every hour',
        duration: 10,
        creationType: CreationTypes.userCreated,
        periodTypes: PeriodTypes.custom,
        selectedDays: [Days.mon, Days.wed, Days.sat],
        frequencyTypes: FrequencyTypes.everyHour
    ),
  ];

  List<Schedule> get getSchedules {
    return [... schedules];
  }

  Schedule getSchedule(String name) {
    Schedule? schedule = schedules.firstWhereOrNull((eachSchedule) =>
    eachSchedule.name == name,
    );

    if (schedule == null) {
      throw ArgumentError('schedule not found.');
    } else {
      return schedule;
    }
  }
}
