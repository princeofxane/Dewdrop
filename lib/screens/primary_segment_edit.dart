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
      bool isCompleted = segmentsProvider.toggleWorker(widget.segment.id, value);
      return isCompleted;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Primary Segment Edit'),
            const SizedBox(height: 100),
            const Text('Segment Name'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: utility.screenWidth(context) * 0.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField(
                controller: _controller,
                onSubmitted: (newName) {
                    bool isCompleted = segmentsProvider.changeName(widget.segment.id, newName);

                    if (!isCompleted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to update the segment name'),
                        )
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Segment name is updated'),
                          )
                      );
                    }
                },
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  hintText: 'Enter a name',
                ),
              ),
            ),
            const SizedBox(height: 100),
            Row(
              children: [
                Text('Turn $toBeAction all workers for $segmentName.'),
                Switch(
                  value: isWorkerActive,
                  onChanged: (value) {
                    if (workerToggle(value)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Worker status has been updated'),
                          )
                      );
                    }
                  }
                )
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
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
                },
                child: Container(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Center(
                    child: Text('Delete'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
