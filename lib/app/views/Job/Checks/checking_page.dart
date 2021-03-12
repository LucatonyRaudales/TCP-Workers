import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'checking_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class CheckinPage extends StatefulWidget {
    final String jobName;
    CheckinPage({
  @required this.jobName,
  });
  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  TimeRange range = TimeRange(startTime: TimeOfDay(hour: 00, minute: 00), endTime: TimeOfDay(hour: 00, minute: 00));

  @override
  Widget build(BuildContext context) {
  return GetBuilder<CheckingCtrl>(
    init: CheckingCtrl(),
    builder: (_)=> Scaffold(
    appBar: AppBar(
      title:new Column(
      children:[
      Text(widget.jobName.toUpperCase(), style: subTitleWhiteFont),
      SizedBox(height: 3,),
      Text('Techno Business Worker', style:minimalWhiteFont),
      ]),
      centerTitle: true,
      backgroundColor: main_color,
      primary: true,
      ),
    body: Center(
      child: SingleChildScrollView(
      child: new Column(children: [
        new Column(
          children: [
            Obx(() => Text(_.hourWorked.value.toString(), style: titleFont)),
            new Text(' hours worked', style: titleFont),
          ],
        ),
      SizedBox(height: 10.sp),
      _checkIn(ctrl: _, context: context),
      ],),
      ),
    ),
    ),
  );
  }

  _checkIn({CheckingCtrl ctrl, BuildContext context}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
    dataColumn(),
    
    SizedBox(height: 45.sp),

    InkWell(
      onTap:()async {
        TimeRange data = await showTimeRangePicker(
          start: TimeOfDay(hour: 7, minute: 0),
          end: TimeOfDay(hour: 17, minute: 0),
          interval: Duration(minutes: 30),
          context: context,
          );
          setState(()=> range = data);
          ctrl.calculateHoursWorked(time: range);
      },
      child: Card(
        child: new ListTile(
          title: new Text('select check-in and check-out time', style: subTitleFont, textAlign: TextAlign.center,),
          trailing: new Icon(Icons.touch_app, color: main_color),
        ),
        ),
    ),

  SizedBox(height: 20,),

  _timeSelect(ctrl: ctrl),

    SizedBox(height: 50.sp),

    RoundedLoadingButton(
      color: main_color,
      errorColor: second_color,
      child: Text('Check today'.toUpperCase(), style: TextStyle(color: Colors.white)),
      controller: ctrl.btnController,
      onPressed:()=> ctrl.setCheck(),
    )
  ]);
  }

  Widget dataColumn({CheckingCtrl ctrl}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          new Text(range.startTime.format(context), style: titleFont),
          new Text('In', style: subTitleFont)
        ]),

        Container(
          color: main_color,
          height: 1.sp,
          width: 25.sp,
        ),

        Column(children:[
          new Text(range.endTime.format(context), style: titleFont),
          new Text('Out', style: subTitleFont)
        ])
      ],
    );
  }

    Widget _timeSelect({CheckingCtrl ctrl}){
    return new Container(
      child: Card(
        child: ListTile(
          subtitle: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            new Text('Lunch minutes', style: bodyFontBold,),
            SizedBox(width: 10.sp),
            new Icon(CupertinoIcons.hand_draw, size: 15.sp, color: main_color)
          ],),
          title: Obx(()=> NumberPicker(
          step: 15,
          textStyle: titleFont,
          axis: Axis.horizontal,
          value: ctrl.breakTime.value,
          minValue: 0,
          maxValue: 90,
          onChanged: (newValue)async{
            ctrl.breakTime.value = newValue;
            ctrl.calculateHoursWorked(time: range);
            },
          )
        ),
        )
      )
    );
  }
}