import 'package:flutter/material.dart';
import '../models/bt_device.dart';
import '../widgets/popup_info.dart';

class DeviceDetail extends StatefulWidget {
  final BTDevice btdevice;
  const DeviceDetail({
    Key? key,
    required this.btdevice
  }) : super(key: key);

  @override
  State<DeviceDetail> createState() => _DeviceDetailState();
}

class _DeviceDetailState extends State<DeviceDetail> {


  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      borderOnForeground: true,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /* ---------- Device details ---------- */
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Text('Name: ${widget.btdevice.name}'),
                  // Text('IpAddress: ${widget.btdevice.ipAddress}'),
                  // Text('MacAddress: ${widget.btdevice.macAddress}'),
                ],
              ),
            ),
            // Spacer(),
            /* ---------- Function buttons ---------- */
            CustomFunctionButtons(
              text: 'Schedule',
              icon: Icons.calendar_month
            ),
            CustomFunctionButtons(
                text: 'Info',
                icon: Icons.info_outline,
                fn: () => customShowDialog(context, widget.btdevice),
            ),
            // CustomFunctionButtons(
            //     text: 'Test',
            //     icon: Icons.play_circle_outline
            // ),
          ],
        ),
      )
    );
  }
}

void customShowDialog(BuildContext context, BTDevice btdevice) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Pass the value of the device here.
            PopupInfo(btdevice: btdevice),
          ],
        ),
        actions: const <Widget>[],
      );
    },
  );
}

class CustomFunctionButtons extends StatelessWidget {
  String text;
  IconData icon;
  Function()? fn;

  CustomFunctionButtons({
    Key? key,
    required this.text,
    required this.icon,
    this.fn
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          InkWell(
            child: Container(
              // height: 50.0,
              // width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: FittedBox(
                child: Icon(icon),
                fit: BoxFit.fill,
              ),
            ),
            onTap: () {
              fn!();
            },
          ),
          Text(text)
          //Text
        ],
      );
  }
}