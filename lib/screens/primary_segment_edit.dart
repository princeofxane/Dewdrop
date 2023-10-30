import 'package:dewdrop/models/segment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utility/device_information.dart' as utility;

class PrimarySegmentEdit extends StatefulWidget {
  static const routeName = '/primary_segment_edit_screen';

  Segment segment;

  PrimarySegmentEdit({
    Key? key,
    required this.segment,
  }) : super(key: key);


  @override
  State<PrimarySegmentEdit> createState() => _PrimarySegmentEditState();
}

class _PrimarySegmentEditState extends State<PrimarySegmentEdit> {

  
  final _controller = TextEditingController();
  String segmentName = '';
  bool isWorkerActive = false;

  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      // Step 2 <- SEE HERE
      _controller.text = widget.segment.name;
      segmentName = widget.segment.name;
      isWorkerActive = widget.segment.isWorkersActive;
  }


  @override
  Widget build(BuildContext context) {

    String toBeAction;
    if (isWorkerActive) {
      toBeAction = "Off";
    } else {
      toBeAction = "On";
    }

    final segmentsProvider = Provider.of<Segments>(context);

    bool workerToggle(bool value) {
      setState(() {
        isWorkerActive = value;
      });
      // bool isCompleted = segmentsProvider.toggleWorker(widget.segment.id, value);
      // return isCompleted;
      return true;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Primary Segment Edit'),
                const Divider(
                  height: 10,
                  thickness: 1,
                  color: Colors.black,
                  // indent: 10,
                  // endIndent: 40,
                ),
                const SizedBox(height: 20),
                const Text('Segment Name'),
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
                        segmentName = newName;
                          // bool isCompleted = segmentsProvider.changeName(widget.segment.id, newName);
                          //
                          // if (!isCompleted) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text('Failed to update the segment name'),
                          //     )
                          //   );
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content: Text('Segment name is updated'),
                          //       )
                          //   );
                          // }
                      },
                      decoration: const InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: 'Enter a name',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Turn $toBeAction all workers for $segmentName.'),
                    Switch(
                      value: isWorkerActive,
                      onChanged: (value) {
                        workerToggle(value);
                        // if (workerToggle(value)) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content: Text('Worker status has been updated'),
                        //       )
                        //   );
                        // }
                      }
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () {

                      // Construct a map with values to be updated.
                      Map<String, dynamic> updatedValues = {
                        'isWorkersActive': isWorkerActive,
                        'name': segmentName
                      };

                      bool hasSaved = segmentsProvider.updateSegment(widget.segment.id, updatedValues);
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
                Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () async{
                      bool canDelete = await deleteWarning(context);
                      if (canDelete) {
                        if (!mounted) return;
                        // Send an api request to delete the segment.

                        bool hasDeleted = segmentsProvider.deleteSegment(widget.segment.id);

                        if (!hasDeleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to delete segment'),
                              )
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Segment has been deleted'),
                              )
                          );
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: const Center(
                          child: Text('Delete',
                            style: TextStyle(
                              color: Colors.red
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Delete warning popup.
Future<bool> deleteWarning(BuildContext context) async{

  final canDelete = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
          // side: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(25))
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20)
              ),
              width: 280,
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.black),
                    //     borderRadius: BorderRadius.circular(20)
                    // ),
                    child: Text('Are you sure you want to delete?')
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context, false);

                            // print('Segment value is $newSegmentName');
                            // bool isCompleted = segmentsProvider.createSegment(newSegmentName);
                            // if (!isCompleted) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text('Failed to create new segment'),
                            //       )
                            //   );
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text('New segment has created'),
                            //       )
                            //   );
                            // }
                            // Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: const Center(
                                child: Text('No'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pop(context, true);
                            // print('Segment value is $newSegmentName');
                            // bool isCompleted = segmentsProvider.createSegment(newSegmentName);
                            // if (!isCompleted) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text('Failed to create new segment'),
                            //       )
                            //   );
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text('New segment has created'),
                            //       )
                            //   );
                            // }
                            // Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: const Center(
                                child: Text('Yes'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );

  return canDelete;

}