import 'package:flutter/material.dart';
import '../models/bt_device.dart';

class PopupInfo extends StatefulWidget {
  final BTDevice btdevice;

  const PopupInfo({Key? key, required this.btdevice}) : super(key: key);

  @override
  State<PopupInfo> createState() => _PopupInfoState();
}

class _PopupInfoState extends State<PopupInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        height: 420,
        child: Column(children: [
          Row(
            // mainAxisSize: MainAxisSize.max,
            children: [
              const Text('Device Info'),
              Spacer(),
              BatteryStrengthDesign(batteryStrength: 5),
              // BatteryIcon(segmentColor: Colors.green, batteryLevel: 3,),
              NetworkCoverageDesign(networkCoverage: 5),
              // InkWell(
              //   onTap: () {},
              //   child: Container(
              //     child: const Expanded(
              //       child: FittedBox(
              //         child: Icon(Icons.cancel),
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormFieldDesign(
                        textFormField: TextFormField(
                          // If the name is available condition.

                          /* ---------- Name ---------- */
                          decoration: widget.btdevice.name == ""
                              ? const InputDecoration(
                                  // icon: const Icon(Icons.person),
                                  border: InputBorder.none,
                                  hintText: 'Enter your name',
                                  labelText: 'Name',
                                )
                              : const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Name',
                                ),
                          initialValue: widget.btdevice.name,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      /* ---------- IP Address ---------- */
                      TextFormFieldDesign(
                        textFormField: TextFormField(
                          // style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            // icon: const Icon(Icons.person),
                            // hintText: 'Enter your name',
                            border: InputBorder.none,
                            labelText: 'IP Address',
                          ),
                          initialValue: widget.btdevice.ipAddress,
                          readOnly: true,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      /* ---------- Mac Address ---------- */
                      TextFormFieldDesign(
                        textFormField: TextFormField(
                          // style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            // icon: const Icon(Icons.person),
                            // hintText: 'Enter your name',

                            border: InputBorder.none,
                            labelText: 'Mac Address',
                          ),
                          initialValue: widget.btdevice.macAddress,
                          readOnly: true,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      /* ---------- Description ---------- */
                      TextFormFieldDesign(
                        textFormField: TextFormField(
                          decoration: widget.btdevice.description == ""
                              ? const InputDecoration(
                                  // icon: const Icon(Icons.person),
                                  border: InputBorder.none,
                                  hintText: 'Enter the description',
                                  labelText: 'Description',
                                )
                              : const InputDecoration(
                                  // icon: const Icon(Icons.person),
                                  // hintText: 'Enter your name',
                                  border: InputBorder.none,
                                  labelText: 'Description',
                                ),
                          initialValue: widget.btdevice.description,
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            /* ---------- Construct your form here. ---------- */
          ),
        ]));
  }
}

class TextFormFieldDesign extends StatelessWidget {
  final TextFormField textFormField;

  const TextFormFieldDesign({Key? key, required this.textFormField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
          child: textFormField,
        ),
      ),
    );
  }
}

class NetworkCoverageDesign extends StatelessWidget {
  int networkCoverage;

  NetworkCoverageDesign({Key? key, required this.networkCoverage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent)
          ),
          child: IntrinsicHeight(
            child: Row(
              children: const [
                // Each bars.
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: Card(
                      color: Colors.red,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 15,
                    height: 20,
                    child: Card(
                      color: Colors.red,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 15,
                    height: 30,
                    child: Card(
                      color: Colors.red,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 15,
                    height: 40,
                    child: Card(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class BatteryStrengthDesign extends StatelessWidget {
  int batteryStrength;
  MaterialColor color;


  BatteryStrengthDesign({
    Key? key,
    this.batteryStrength = 0,
    this.color = Colors.red
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 30,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
      ),

    );
  }
}

// class BatteryIcon extends StatelessWidget {
//   int batteryLevel;
//   double segmentHeight;
//   double segmentWidth;
//   Color segmentColor;
//   BatteryIcon(
//       {Key? key,
//         this.batteryLevel = 0,
//         this.segmentHeight = 10,
//         this.segmentWidth = 30,
//         this.segmentColor = Colors.transparent})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: segmentWidth * 0.5,
//           height: segmentHeight * 0.6,
//           decoration: BoxDecoration(
//               color: batteryLevel >= 5 ? segmentColor : Colors.transparent,
//               border: const Border(
//                 top: BorderSide(width: 1.0, color: Colors.white),
//                 right: BorderSide(width: 1.0, color: Colors.white),
//                 left: BorderSide(width: 1.0, color: Colors.white),
//               )),
//         ),
//         Container(
//           width: segmentWidth,
//           height: segmentHeight,
//           decoration: BoxDecoration(
//               color: batteryLevel >= 4 ? segmentColor : Colors.transparent,
//               borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(5), topLeft: Radius.circular(5)),
//               border: Border.all(color: Colors.white, width: 1)),
//         ),
//         Container(
//           width: segmentWidth,
//           height: segmentHeight,
//           decoration: BoxDecoration(
//               color: batteryLevel >= 3 ? segmentColor : Colors.transparent,
//               border: const Border(
//                   bottom: BorderSide(width: 1.0, color: Colors.white),
//                   right: BorderSide(width: 1.0, color: Colors.white),
//                   left: BorderSide(width: 1.0, color: Colors.white))),
//         ),
//         Container(
//           width: segmentWidth,
//           height: segmentHeight,
//           decoration: BoxDecoration(
//               color: batteryLevel >= 2 ? segmentColor : Colors.transparent,
//               border: const Border(
//                   right: BorderSide(width: 1.0, color: Colors.white),
//                   left: BorderSide(width: 1.0, color: Colors.white))),
//         ),
//         Container(
//           width: segmentWidth,
//           height: segmentHeight,
//           decoration: BoxDecoration(
//               color: batteryLevel >= 1 ? segmentColor : Colors.transparent,
//               borderRadius: const BorderRadius.only(
//                   bottomRight: Radius.circular(5),
//                   bottomLeft: Radius.circular(5)),
//               border: Border.all(color: Colors.white, width: 1)),
//         ),
//       ],
//     );
//   }
// }

