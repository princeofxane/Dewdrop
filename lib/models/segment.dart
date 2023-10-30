import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/bt_device.dart';
import '../models/schedule.dart';
import '../models/sub_segment.dart';
import 'package:collection/collection.dart';
import '../utility/device_information.dart' as utility;


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

  Map<String, dynamic> _toMap() {
    return {
      'name': name,
      'isWorkersActive': isWorkersActive,
    };
  }
  //
  dynamic get(String propertyName) {
    var mapRep = _toMap();
    if (mapRep.containsKey(propertyName)) {
      return mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }
  //
  bool set(String propertyName, dynamic value) {

    var mapRep = _toMap();
    if (mapRep.containsKey(propertyName)) {
      print('------abc--------');
      print(mapRep[propertyName]);
      print(value);
      print('--------------');
      // mapRep[propertyName] = value;
    }
    return true;
  }

}


class Segments with ChangeNotifier{
  List<Segment> segments = [
    Segment(
      id: 'ef12',
      name: 'House',
      isWorkersActive: true,
      subsegments: [
        SubSegments().subSegments[0],
        SubSegments().subSegments[1],
      ]
    ),
    Segment(
        id: 'ef13',
        name: 'Office',
        isWorkersActive: true,
        subsegments: [
          SubSegments().subSegments[2],
        ]
    ),
    Segment(
        id: 'ef14',
        name: 'Farm1',
        isWorkersActive: true,
        subsegments: [
          SubSegments().subSegments[3],
          SubSegments().subSegments[4],
        ]
    ),
  ];


  List<Segment> get getSegments {
    return [... segments];
  }


  bool updateSegment(String id, Map<String, dynamic> updatedValues) {

    Segment? segment = segments.firstWhereOrNull((eachSegment) =>
    eachSegment.id == id,
    );

    if (segment == null) {
      return false;
    }

    updatedValues.forEach((key, value) {
      // print("Key : $key, Value : $value");
      switch (key) {
        case 'name':
          segment.name = utility.cast<String>(value)!;
          break;
        case 'isWorkersActive':
          segment.isWorkersActive = utility.cast<bool>(value)!;
          break;
        default :
          print('invalid field name provided');
          break;
      }
      // segment.set(key, value);
    });

    notifyListeners();
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

    segments.removeWhere((eachSegment) =>
      eachSegment.id == id,
    );

    notifyListeners();
    return true;
  }

  bool createSegment(String segmentName) {

    Segment newSegment = Segment(
      id: utility.getRandomString(5),
      name: segmentName,
      subsegments: <SubSegment>[],
      isWorkersActive: false
    );

    segments.add(newSegment);
    notifyListeners();
    return true;
  }

}
// bool toggleWorker(String id, bool value) {
//   Segment? segment = segments.firstWhereOrNull((eachSegment) =>
//   eachSegment.id == id,
//   );
//
//   if (segment == null) {
//     return false;
//   }
//
//   segment.isWorkersActive = value;
//
//   return true;
// }

// bool changeName(String id, String name) {
//   Segment? segment = segments.firstWhereOrNull((eachSegment) =>
//     eachSegment.id == id,
//   );
//
//   if (segment == null) {
//     return false;
//   }
//
//   segment.name = name;
//
//   return true;
// }

