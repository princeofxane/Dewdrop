import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/bt_device.dart';
import '../models/schedule.dart';
import 'package:collection/collection.dart';
import 'dart:math';

/* ---------- random string generator ---------- */
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
  Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
  )
);
/* --------------------------------------------- */

class Segment {
  final String id;
  String name;
  bool isWorkersActive;
  List<SubSegment> subsegments;

  Segment({
    required this.id,
    required this.name,
    required this.isWorkersActive,
    required this.subsegments
  });
}

class SubSegment {
  final String id;
  final String name;
  final bool isIndoor;
  final bool isActiveAtNight;
  BTDevice? btDevice;
  Schedule? schedule;

  SubSegment({
    required this.id,
    required this.name,
    required this.isIndoor,
    required this.isActiveAtNight,
    this.btDevice,
    this.schedule
  });
}


class Segments with ChangeNotifier{
  List<Segment> segments = [
    Segment(
      id: 'ef12',
      name: 'House',
      isWorkersActive: true,
      subsegments: [
        SubSegment(
          id: 'hi12',
          name: 'living room',
          isIndoor: false,
          isActiveAtNight: true,
          btDevice: BTDevice(
            id: 'ab12',
            name: 'cat',
            description: 'my device',
            ipAddress: '192.168.1.25',
            macAddress: '8c:73:6e:b7:13:f5',
            isActive: true,
            power: 56
          ),
          schedule: Schedule(
            id: 'cd12',
            name: 'Every day two hours',
            duration: 10,
            creationType: CreationTypes.preset,
            periodTypes: PeriodTypes.daily,
            frequencyTypes: FrequencyTypes.everyTwoHour
          )
        ),
        SubSegment(
          id: 'hi13',
          name: 'balcony',
          isIndoor: false,
          isActiveAtNight: true,
          btDevice: BTDevice(
            id: 'ab12',
            name: 'cat',
            description: 'my device',
            ipAddress: '192.168.1.25',
            macAddress: '8c:73:6e:b7:13:f5',
            isActive: true,
            power: 56
          ),
          schedule: Schedule(
            id: 'cd12',
            name: 'Every day two hours',
            duration: 10,
            creationType: CreationTypes.preset,
            periodTypes: PeriodTypes.daily,
            frequencyTypes: FrequencyTypes.everyTwoHour
          )
        ),
      ]
    ),
    Segment(
        id: 'ef13',
        name: 'Office',
        isWorkersActive: true,
        subsegments: [
          SubSegment(
              id: 'hi12',
              name: 'living room',
              isIndoor: false,
              isActiveAtNight: true,
              btDevice: BTDevice(
                  id: 'ab12',
                  name: 'cat',
                  description: 'my device',
                  ipAddress: '192.168.1.25',
                  macAddress: '8c:73:6e:b7:13:f5',
                  isActive: true,
                  power: 56
              ),
              schedule: Schedule(
                  id: 'cd12',
                  name: 'Every day two hours',
                  duration: 10,
                  creationType: CreationTypes.preset,
                  periodTypes: PeriodTypes.daily,
                  frequencyTypes: FrequencyTypes.everyTwoHour
              )
          ),
        ]
    ),
    Segment(
        id: 'ef14',
        name: 'Farm1',
        isWorkersActive: true,
        subsegments: [
          SubSegment(
              id: 'hi12',
              name: 'Section A',
              isIndoor: false,
              isActiveAtNight: true,
              btDevice: BTDevice(
                  id: 'ab12',
                  name: 'cat',
                  description: 'my device',
                  ipAddress: '192.168.1.25',
                  macAddress: '8c:73:6e:b7:13:f5',
                  isActive: true,
                  power: 56
              ),
              schedule: Schedule(
                  id: 'cd12',
                  name: 'Every day two hours',
                  duration: 10,
                  creationType: CreationTypes.preset,
                  periodTypes: PeriodTypes.daily,
                  frequencyTypes: FrequencyTypes.everyTwoHour
              )
          ),
          SubSegment(
              id: 'hi13',
              name: 'Section B',
              isIndoor: false,
              isActiveAtNight: true,
              btDevice: BTDevice(
                  id: 'ab12',
                  name: 'cat',
                  description: 'my device',
                  ipAddress: '192.168.1.25',
                  macAddress: '8c:73:6e:b7:13:f5',
                  isActive: true,
                  power: 56
              ),
              schedule: Schedule(
                  id: 'cd12',
                  name: 'Every day two hours',
                  duration: 10,
                  creationType: CreationTypes.preset,
                  periodTypes: PeriodTypes.daily,
                  frequencyTypes: FrequencyTypes.everyTwoHour
              )
          ),
        ]
    ),
  ];

  List<Segment> get getSegments {
    return [... segments];
  }

  bool toggleWorker(String id, bool value) {
    Segment? segment = segments.firstWhereOrNull((eachSegment) =>
    eachSegment.id == id,
    );

    if (segment == null) {
      return false;
    }

    segment.isWorkersActive = value;

    return true;
  }

  bool changeName(String id, String name) {
    Segment? segment = segments.firstWhereOrNull((eachSegment) =>
      eachSegment.id == id,
    );

    if (segment == null) {
      return false;
    }

    segment.name = name;

    return true;
  }

  bool ifSegmentExist(String id) {
    Segment? segment = segments.firstWhereOrNull((eachSegment) =>
    eachSegment.id == id,
    );

    if (segment == null) {
      return false;
    } else {
      return true;
    }
  }


  bool deleteSegment(String id) {

    print('===================');
    print('Before delete array');
    print(segments.map((e) => print(e.name)));
    print('===================');

    segments.removeWhere((eachSegment) =>
    eachSegment.id == id,
    );

    print('===================');
    print('After delete array');
    print(segments.map((e) => print(e.name)));
    print('===================');

    notifyListeners();
    return true;
  }

    bool createSegment(String segmentName) {

    Segment newSegment = Segment(
      id: getRandomString(5),
      name: segmentName,
      subsegments: <SubSegment>[],
      isWorkersActive: false
    );

    segments.add(newSegment);
    notifyListeners();
    return true;
  }
}
// if (eachSegment.id == id) {
// eachSegment.name = name;
// }
