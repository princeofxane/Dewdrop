import 'package:flutter/material.dart';
import '../models/sub_segment.dart';
import '../models/segment.dart';
import 'package:dewdrop/models/bt_device.dart';
import 'package:dewdrop/models/schedule.dart';
import 'package:provider/provider.dart';
import '../utility/device_information.dart' as utility;

const List<String> locationParameters = <String>['indoor', 'outdoor'];


class SubSegmentCreate extends StatefulWidget {
  final String primarySegmentId;
  final String primarySegmentName;

  const SubSegmentCreate({
    super.key,
    required this.primarySegmentId,
    required this.primarySegmentName
  });

  @override
  State<SubSegmentCreate> createState() => _SubSegmentEditState();
}

class _SubSegmentEditState extends State<SubSegmentCreate> {

  final _controller = TextEditingController();
  String? locationSelection = 'indoor';
  String? subSegmentName = '';
  String? selectedScheduleId = '';
  String? selectedDeviceId = '';
  bool? isActiveAtNight = true;
  bool? isWorkerActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Step 2 <- SEE HERE
    // _controller.text = widget.subSegment.name;
    // scheduleSelection = widget.subSegment.schedule?.name;
  }

  @override
  Widget build(BuildContext context) {

    final subSegmentData = Provider.of<SubSegments>(context, listen: true);
    final subSegments = subSegmentData.subSegments;

    final deviceData = Provider.of<BTDevices>(context);
    final devices = deviceData.devices;
    // deviceSelection = devices.first;

    final scheduleData = Provider.of<Schedules>(context);
    final schedules = scheduleData.schedules;
    // scheduleSelection = schedules.first;

    if(selectedDeviceId == '') {
      selectedDeviceId = devices.first.id;
    }

    if(selectedScheduleId == '') {
      selectedScheduleId = schedules.first.id;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create Sub Segment for ${widget.primarySegmentName}'),
                const Divider(
                  height: 10,
                  thickness: 1,
                  color: Colors.black,
                  // indent: 10,
                  // endIndent: 40,
                ),
                /* ---------- Name ---------- */
                const SizedBox(height: 20),
                Text('Name'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    // width: utility.screenWidth(context) * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (newName) {
                        subSegmentName = newName;

                      //   bool isCompleted = segmentsProvider.changeName(widget.segment.id, newName);
                      //
                      //   if (!isCompleted) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text('Failed to update the segment name'),
                      //       )
                      //     );
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text('Segment name is updated'),
                      //       )
                      //     );
                      //   }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter a name',
                      ),
                    ),
                  )
                ),
                /* ---------- Worker ---------- */
                const SizedBox(height: 20),
                const Text('Worker Device'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    // width: utility.screenWidth(context) * 0.5,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        isExpanded: true,
                        hint: const Text('Select a device'),
                        // isExpanded: true,
                        value: selectedDeviceId,
                        onChanged: (String? val){
                          setState(() {
                            selectedDeviceId = val;
                          });
                        },
                        // onChanged: (Segment? newValue) {
                        //   setState(() {
                        //     if (newValue == null) return;
                        //     valueChoose = newValue;
                        //     segmentIndex = segments.indexOf(newValue);
                        //     subSegments = segments[segmentIndex].subSegments;
                        //   });
                        // },
                        items: devices.map((deviceValue) {
                          return DropdownMenuItem(
                              value: deviceValue.id,
                              child: Text(deviceValue.name)
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                // /* ---------- Schedule ---------- */
                const SizedBox(height: 20),
                Text('Schedule'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    // width: utility.screenWidth(context) * 0.5,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        isExpanded: true,
                        hint: const Text('Select a location type'),
                        // isExpanded: true,
                        value: selectedScheduleId,
                        onChanged: (String? val){
                          setState(() {
                            selectedScheduleId = val;
                          });
                        },
                        // onChanged: (Segment? newValue) {
                        //   setState(() {
                        //     if (newValue == null) return;
                        //     valueChoose = newValue;
                        //     segmentIndex = segments.indexOf(newValue);
                        //     subSegments = segments[segmentIndex].subSegments;
                        //   });
                        // },
                        items: schedules.map((scheduleValue) {
                          return DropdownMenuItem(
                              value: scheduleValue.id,
                              child: Text(scheduleValue.name)
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                // /* ---------- Location Type ---------- */
                const SizedBox(height: 20),
                const Text('Indoor or Outdoor'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    // width: utility.screenWidth(context) * 0.5,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        isExpanded: true,
                        hint: const Text('Select a location type'),
                        // isExpanded: true,
                        value: locationSelection,
                        onChanged: (String? val){
                          setState(() {
                            locationSelection = val!;
                          });
                        },
                        // onChanged: (Segment? newValue) {
                        //   setState(() {
                        //     if (newValue == null) return;
                        //     valueChoose = newValue;
                        //     segmentIndex = segments.indexOf(newValue);
                        //     subSegments = segments[segmentIndex].subSegments;
                        //   });
                        // },
                        items: locationParameters.map((locationValue) {
                          return DropdownMenuItem(
                              value: locationValue,
                              child: Text(locationValue)
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text('Avoid watering in the night'),
                    Switch(
                      onChanged: (val){
                        setState(() {
                          isActiveAtNight = val;
                        });
                      },
                      value: () {
                        if (isActiveAtNight!) {
                          return true;
                        }
                        return false;
                      }(),
                      // value: isWorkerActive,
                      // onChanged: (value) {
                      //   if (workerToggle(value)) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //           content: Text('Worker status has been updated'),
                      //         )
                      //     );
                      //   }
                      // }
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Turn off the worker'),
                    Switch(
                      onChanged: (val) {
                        setState(() {
                          isWorkerActive = val;
                        });
                      },
                      value: () {
                        if (isWorkerActive!) {
                          return true;
                        }
                        return false;
                      }(),
                      // value: isWorkerActive,
                      // onChanged: (value) {
                      //   if (workerToggle(value)) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //           content: Text('Worker status has been updated'),
                      //         )
                      //     );
                      //   }
                      // }
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () {

                      Map<String, dynamic> updatedValues = {
                        'name': subSegmentName,
                        'deviceSelection': selectedDeviceId,
                        'scheduleSelection': selectedScheduleId,
                        'isIndoor': locationSelection,
                        'isActiveAtNight': isActiveAtNight,
                        'isWorkerActive': isWorkerActive
                      };

                      bool hasSaved = subSegmentData.createSubSegment(widget.primarySegmentId, updatedValues);


                      // bool hasDeleted = segmentsProvider.deleteSegment(widget.segment.id);
                      //
                      // if (!hasDeleted) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text('Failed to delete segment'),
                      //       )
                      //   );
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text('Segment has been deleted'),
                      //       )
                      //   );
                      // }
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: const Center(
                          child: Text('Save',
                              style: TextStyle(
                                  color: Colors.blue
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
