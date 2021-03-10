import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';

class MySelect extends StatelessWidget {
  final String title = 'dropDown';
  String friendVal;
  List friendName = ['hjuan', 'bnito', 'kmlo', 'auxilio'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:18.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: main_color),
          borderRadius: BorderRadius.circular(25)
        ),
        child: DropdownButton(
          hint: new Text('Select'),
          dropdownColor: Colors.lightBlue,
          style: subTitleFont,
          elevation: 5,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 30.sp,
          value: friendVal,
          onChanged: (val) => friendVal = val,
          items: friendName.map((e){
            return DropdownMenuItem(
              value: e,
              child:  new Text(e),
            );
          }).toList(),
        ),
      ),
    );
  }
}