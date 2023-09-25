import 'package:flutter/material.dart';
import '../models/segment.dart';

class SubSegmentDetail extends StatefulWidget {
  final SubSegment subsegment;
  const  SubSegmentDetail({
    Key? key,
    required this.subsegment
  }) : super(key: key);

  @override
  State< SubSegmentDetail> createState() => _SubSegmentDetailState();
}

class _SubSegmentDetailState extends State< SubSegmentDetail> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Create a drop down list.
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: screenWidth * 0.1,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Text(widget.subsegment.name),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    print('edit');
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)
                      ),
                      child: Icon(Icons.edit)
                  ),
                ),
              ),
            ],
          )
        ),

      ),
    );
  }
}
