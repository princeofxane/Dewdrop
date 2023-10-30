import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/bt_device.dart';
import '../models/schedule.dart';
import 'package:collection/collection.dart';
import '../utility/device_information.dart' as utility;

class SubSegment {
  final String id;
  String name;
  bool isIndoor;
  bool isActiveAtNight;
  bool isWorkerActive;
  BTDevice? btDevice;
  Schedule? schedule;

  SubSegment({
    required this.id,
    required this.name,
    required this.isIndoor,
    required this.isActiveAtNight,
    required this.isWorkerActive,
    this.btDevice,
    this.schedule
  });

}
class SubSegments with ChangeNotifier{
  List<SubSegment> subSegments = [
    SubSegment(
        id: 'hi10',
        name: 'living room',
        isIndoor: true,
        isActiveAtNight: false,
        isWorkerActive: true,
        btDevice: BTDevice(
            id: 'ab12',
            name: 'dog',
            description: 'my device',
            ipAddress: '192.168.1.25',
            macAddress: '8c:73:6e:b7:13:f5',
            isActive: true,
            power: 56
        ),
        schedule: Schedule(
            id: 'cd12',
            name: 'Alternative and two hours',
            duration: 10,
            creationType: CreationTypes.preset,
            periodTypes: PeriodTypes.daily,
            frequencyTypes: FrequencyTypes.everyTwoHour
        )
    ),
    SubSegment(
        id: 'hi11',
        name: 'balcony',
        isIndoor: false,
        isActiveAtNight: true,
        isWorkerActive: false,
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
        id: 'hi12',
        name: 'meeting room',
        isIndoor: false,
        isActiveAtNight: true,
        isWorkerActive: true,
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
        name: 'Section A',
        isIndoor: false,
        isActiveAtNight: true,
        isWorkerActive: true,
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
        id: 'hi14',
        name: 'Section B',
        isIndoor: false,
        isActiveAtNight: true,
        isWorkerActive: true,
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
  ];

  List<SubSegment> get getSegments {
    return [... subSegments];
  }

  // testFunc() {
  //   subSegments.forEach((e) {
  //     print('sub segment names');
  //     print(e.name);
  //   });
  // }

  bool updateSubSegment(String id, Map<String, dynamic> updatedValues) {

    SubSegment? subSegment = subSegments.firstWhereOrNull((eachSubSegment) =>
      eachSubSegment.id == id,
    );

    if (subSegment == null) {
      return false;
    }

    updatedValues.forEach((key, value) {
      // print("Key : $key, Value : $value");
      switch (key) {
        case 'name':
          subSegment.name = utility.cast<String>(value)!;
          // subSegment.name = value;
          break;
        case 'deviceSelection':
          BTDevice? changedBTDevice = BTDevices().getDevice(value);
          subSegment.btDevice = changedBTDevice;
          break;
        case 'scheduleSelection':
          Schedule? changedSchedule = Schedules().getSchedule(value);
          subSegment.schedule = changedSchedule;
          break;
        case 'isIndoor':
          if (value == 'indoor') {
            subSegment.isIndoor = true;
          } else {
            subSegment.isIndoor = false;
          }
          break;
        case 'isActiveAtNight':
          subSegment.isActiveAtNight = utility.cast<bool>(value)!;
          break;
        case 'isWorkerActive':
          subSegment.isWorkerActive = utility.cast<bool>(value)!;
          break;
        default :
          print('invalid field name provided');
          break;
      }
      // segment.set(key, value);
    });

    subSegments.forEach((e) {
      print('sub segment names');
      print(e.name);
    });

    notifyListeners();
    return true;
  }
}
