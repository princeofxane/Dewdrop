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
  bool _expanded = false;


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      // borderOnForeground: true,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ExpansionPanelList(
          animationDuration: Duration(milliseconds: 1000),
          children: [
            ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return Row(
                  children: [
                    Text('data'),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)
                        ),
                        child: Text('info'),
                      ),
                    )
                  ],
                );
              },
              body: Column(
                children: [
                  Text('Sample description about the device'),
                  OverflowBar(
                    children: [
                      CustomFunctionButtons(
                        text: 'Schedule',
                        icon: Icons.calendar_month
                      ),
                      CustomFunctionButtons(
                        text: 'Info',
                        icon: Icons.info_outline,
                        fn: ()=>deviceInfoPopUp(context, widget.btdevice)),
                      CustomFunctionButtons(
                        text: 'Test',
                        icon: Icons.play_circle_outline
                      )
                    ],
                  )
                ],
              ),
              isExpanded: _expanded,
              canTapOnHeader: true,
            )
          ],
          elevation: 0,
          expansionCallback: (panelIndex, isExpanded) {
            _expanded = !_expanded;
            setState(() {

            });
          },
        )
      )
    );
  }
}

// deviceInfoPopUp shows a popup window to edit information.
void deviceInfoPopUp(BuildContext context, BTDevice btdevice) {
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