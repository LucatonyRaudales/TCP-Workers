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

class CheckinPage extends StatelessWidget {
  final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  final String jobName;
  CheckinPage({
  @required this.jobName
  });

  @override
  Widget build(BuildContext context) {
  return GetBuilder<CheckingCtrl>(
    builder: (_)=> Scaffold(
    appBar: AppBar(
      title:new Column(
      children:[
      Text(jobName.toUpperCase(), style: subTitleWhiteFont),
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

      SizedBox(height: 3.sp),
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
      TimeRange result = await showTimeRangePicker(
        start: TimeOfDay(hour: 7, minute: 0),
        end: TimeOfDay(hour: 17, minute: 0),
				interval: Duration(minutes: 30),
        context: context,
        );
        print(result.startTime.format(context));
    },
    child: Card(
      child: new ListTile(
        title: new Text('Select hours worked', style: titleFont, textAlign: TextAlign.center,),
        trailing: new Icon(Icons.touch_app, color: main_color),
      ),
      ),
  ),

  SizedBox(height: 20,),

  _timeSelect(),

    SizedBox(height: 50.sp),

    RoundedLoadingButton(
      color: main_color,
      errorColor: second_color,
      child: Text('Check today'.toUpperCase(), style: TextStyle(color: Colors.white)),
      controller: btnController,
      onPressed:()=> print('holas'),
    )
  ]);
  }

  Widget dataColumn(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          new Text('11:00 AM', style: titleFont),
          new Text('In', style: subTitleFont)
        ]),

        Container(
          color: main_color,
          height: 1.sp,
          width: 25.sp,
        ),

        Column(children:[
          new Text('06:30 PM', style: titleFont),
          new Text('Out', style: subTitleFont)
        ])
      ],
    );
  }

    Widget _timeSelect(){
    return NumberPicker.integer(
      step: 15,
      textStyle: bodyFont,
      scrollDirection: Axis.horizontal,
      initialValue: 0,
      minValue: 0,
      maxValue: 105,
      onChanged: (newValue) => print(newValue),
      );
  }
}