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
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 53,
        width: screenWidth * 0.3,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.subsegment.name),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: (){
                  print('edit');
                },
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Icon(Icons.edit)
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
