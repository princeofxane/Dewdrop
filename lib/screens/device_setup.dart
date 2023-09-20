import 'package:dewdrop/models/bt_device.dart';
import 'package:dewdrop/widgets/device_card.dart';
import 'package:flutter/material.dart';
import '../screens/device_setup.dart';
import 'package:provider/provider.dart';

class DeviceSetupScreen extends StatefulWidget {
  static const routeName = '/device_setup-screen';

  const DeviceSetupScreen({Key? key}) : super(key: key);

  @override
  State<DeviceSetupScreen> createState() => _DeviceSetupScreenState();
}

class _DeviceSetupScreenState extends State<DeviceSetupScreen> {

  bool initialScreen = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    //Get the devices.
    final deviceData = Provider.of<BTDevices>(context);
    final devices = deviceData.devices;

    void loadDeviceWidgets() {
      setState(() {
        initialScreen = false;
      });
    }

    return Scaffold(
      body: initialScreen ? const Center(
        child: Text('Click on sync to find the devices'),
      ) : Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                    DeviceDetail(btdevice: devices[index])
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadDeviceWidgets();
        },
        // foregroundColor: customizations[index].$1,
        // backgroundColor: customizations[index].$2,
        // shape: customizations[index].$3,
        child: const Icon(Icons.sync),
      ),
    );
  }
}
