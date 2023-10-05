import 'package:dewdrop/models/bt_device.dart';
import 'package:dewdrop/models/segment.dart';
import 'package:dewdrop/screens/primary_segment_edit.dart';
import 'package:dewdrop/widgets/device_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/sub_segment_card.dart';

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
            tabs: const [
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
            Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* ---------- Text: Primary Segment and Add button ---------- */
                  Container(
                    width: screenWidth * 0.7,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.blue)
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Text('Primary Segments'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Icon(Icons.add)),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  /* ---------- Segment Dropdown List ---------- */
                  Container(
                    width: screenWidth * 0.7,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    // width: screenWidth * 0.7,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          width: screenWidth * 0.5,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              borderRadius: BorderRadius.circular(10),
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36,
                              hint: Text('Select a Segment'),
                              // isExpanded: true,
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
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PrimarySegmentEdit(
                                      segment: segments[segmentIndex]
                                    )
                                )
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Icon(Icons.edit)),
                        ),
                      ],
                    ),
                  ),
                  /* ---------- Text: Sub Segment and Add button ---------- */
                  Container(
                    width: screenWidth * 0.7,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.blue)
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Text('Sub Segments'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('edit');
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Icon(Icons.add)),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  /* ---------- Sub Segment List ---------- */
                  Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.red),
                    //     borderRadius: BorderRadius.circular(20)
                    // ),
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: screenWidth * 0.7,
                    height: screenHeight * 0.5,
                    child: ListView.builder(
                      // Get segment length for preset segments.
                      itemCount: subSegments.length,
                      itemBuilder: (_, index) {
                        return SubSegmentDetail(subsegment: subSegments[index]);
                      }
                    ),
                  )
                ],
              ),
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
