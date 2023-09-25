import 'package:dewdrop/models/bt_device.dart';
import 'package:dewdrop/models/segment.dart';
import 'package:dewdrop/widgets/device_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/segment_card.dart';

class DeviceSetupScreen extends StatefulWidget {
  static const routeName = '/device_setup-screen';

  const DeviceSetupScreen({Key? key}) : super(key: key);

  @override
  State<DeviceSetupScreen> createState() => _DeviceSetupScreenState();
}

class _DeviceSetupScreenState extends State<DeviceSetupScreen> {

  bool initialScreen = true;
  Segment? valueChoose;
  int segmentIndex = 0;
  List<SubSegment> subSegments = [];
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    //Get the devices.
    final deviceData = Provider.of<BTDevices>(context);
    final devices = deviceData.devices;

    // Get the segments.
    final segmentData = Provider.of<Segments>(context);
    final segments = segmentData.segments;

    void loadDeviceWidgets() {
      setState(() {
        initialScreen = false;
      });
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            onTap: (tabIndx) {
              // Call set state function where it registers the index.
              setState(() {
                tabIndex = tabIndx;
              });
            },
            tabs: [
              Tab(text: 'Device Setup'),
              Tab(text: 'Segment Setup'),
            ],
          ),
          // title: const Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
          /* ---------- Device Setup Screen ---------- */
            initialScreen ?
            const Center(
              child: Text('Click on sync to find the devices'),
            ) : Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Devices",
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.9,
                  // Note: ListView already contains scrolling functionality.
                  // No need to wrap it with SingleChildScrollView.
                  child: ListView.builder(
                      itemCount: devices.length,
                      // itemBuilder: (_, index) => UserProductItem(productsData.items[index].title, productsData.items[index].imageUrl)
                      itemBuilder: (_, index) =>
                          DeviceDetail(btdevice: devices[index])),
                ),
              ],
            ),
          /* ---------- Segment Setup Screen ---------- */
            Column(
              children: [
                /* ---------- Segment Dropdown List ---------- */
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: screenWidth * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 36,
                                hint: Text('Select a Segment'),
                                isExpanded: true,
                                // onChanged: (_)=>{},
                                value: valueChoose,
                                onChanged: (Segment? newValue) {
                                  setState(() {
                                    if (newValue == null) return;
                                    valueChoose = newValue;
                                    subSegments =
                                        segments[segments.indexOf(newValue)]
                                            .subsegments;
                                  });
                                },
                                items: segments.map((segment) {
                                  return DropdownMenuItem(
                                      value: segment, child: Text(segment.name));
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('edit');
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)),
                          child: Icon(Icons.edit)),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      onTap: () {
                        print('edit');
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)),
                          child: Icon(Icons.add)),
                    ),
                  ],
                ),
                /* ---------- Title ---------- */
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text('Sub Segments'),
                  ),
                ),
                /* ---------- Sub Segment List ---------- */
                SizedBox(
                  height: screenHeight * 0.3,
                  child: ListView.builder(
                    // Get segment length for preset segments.
                    itemCount: subSegments.length,
                    itemBuilder: (_, index) {
                      return SubSegmentDetail(subsegment: subSegments[index]);
                    }
                  ),
                )
              ],
            )
        ]),
        floatingActionButton: tabIndex == 0 ?
        FloatingActionButton(
          onPressed: () {
            loadDeviceWidgets();
          },
          // foregroundColor: customizations[index].$1,
          // backgroundColor: customizations[index].$2,
          // shape: customizations[index].$3,
          child: const Icon(Icons.sync),
        ) : null,
      ),
    );
  }
}
