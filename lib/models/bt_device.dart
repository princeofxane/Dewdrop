import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/bt_device.dart';

class BTDevice {
  final String id;
  final String name;
  final String description;
  final String ipAddress;
  final String macAddress;
  final bool isActive;
  final int power;

  BTDevice({
    required this.id,
    required this.name,
    required this.description,
    required this.ipAddress,
    required this.macAddress,
    required this.isActive,
    required this.power
  });

}


class BTDevices with ChangeNotifier{
  List<BTDevice> devices = [
    BTDevice(
        id: 'ab12',
        name: 'cat',
        description: 'my device',
        ipAddress: '192.168.1.25',
        macAddress: '8c:73:6e:b7:13:f5',
        isActive: true,
        power: 56
    ),
    BTDevice(
        id: 'ab23',
        name: 'dog',
        description: 'my device',
        ipAddress: '192.168.1.26',
        macAddress: '8c:73:6e:b7:13:f6',
        isActive: true,
        power: 50
    ),
    BTDevice(
        id: 'ab34',
        name: 'mouse',
        description: 'my device',
        ipAddress: '192.168.1.27',
        macAddress: '8c:73:6e:b7:13:f7',
        isActive: true,
        power: 25
    ),
    BTDevice(
        id: 'ab34',
        name: 'mouse',
        description: 'my device',
        ipAddress: '192.168.1.27',
        macAddress: '8c:73:6e:b7:13:f7',
        isActive: true,
        power: 25
    ),
    BTDevice(
        id: 'ab34',
        name: 'mouse',
        description: 'my device',
        ipAddress: '192.168.1.27',
        macAddress: '8c:73:6e:b7:13:f7',
        isActive: true,
        power: 25
    ),
    BTDevice(
        id: 'ab34',
        name: 'mouse',
        description: 'my device',
        ipAddress: '192.168.1.27',
        macAddress: '8c:73:6e:b7:13:f7',
        isActive: true,
        power: 25
    ),
    BTDevice(
        id: 'ab34',
        name: 'mouse',
        description: 'my device',
        ipAddress: '192.168.1.27',
        macAddress: '8c:73:6e:b7:13:f7',
        isActive: true,
        power: 25
    ),
    BTDevice(
        id: 'ab34',
        name: 'mouse',
        description: 'my device',
        ipAddress: '192.168.1.27',
        macAddress: '8c:73:6e:b7:13:f7',
        isActive: true,
        power: 25
    ),
    BTDevice(
        id: 'ab34',
        name: 'mouse',
        description: 'my device',
        ipAddress: '192.168.1.27',
        macAddress: '8c:73:6e:b7:13:f7',
        isActive: true,
        power: 25
    ),
    BTDevice(
        id: 'ab34',
        name: 'mouse',
        description: 'my device',
        ipAddress: '192.168.1.27',
        macAddress: '8c:73:6e:b7:13:f7',
        isActive: true,
        power: 25
    ),
    BTDevice(
        id: 'ab34',
        name: 'mouse',
        description: 'my device',
        ipAddress: '192.168.1.27',
        macAddress: '8c:73:6e:b7:13:f7',
        isActive: true,
        power: 25
    ),
  ];

  List<BTDevice> get getDevices {
    return [... devices];
  }
}
