import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/bt_device.dart';
import '../models/schedule.dart';

class Segment {
  final String id;
  final String name;
  final bool isPreset;
  List<SubSegment> subsegments;

  Segment({
    required this.id,
    required this.name,
    required this.isPreset,
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
      isPreset: true,
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
        isPreset: true,
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
        isPreset: true,
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
}
