import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Checks/checking_page.dart';
import 'job_controller.dart';

class JobPage extends StatelessWidget {
  const JobPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobCtrl>(
      init: JobCtrl(),
      builder: (ctrl)=> Scaffold(
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.ssp),
            child: new Column(children: [
              dataView(ctrl: ctrl),
              _buttonCards(ctrl: ctrl)
            ],),
          ),
        )
      ));
  }

  Widget dataView({JobCtrl ctrl}){
    return new Container(
      width: Get.width,
      height: 220.sp,
      child: Column(
        children: [
          new Text(ctrl.jobData.name.toUpperCase(), style: titleFont),
          SizedBox(height: 10.sp,),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            new Text('Orlando, Florida', style: subTitleFont),

            new Text('By ' + ctrl.jobData.type, style: subTitleFont),
          ],),


        Divider(
          height: 30.sp,
          indent: 35.sp,
          endIndent: 35.sp,
          thickness: 1.sp,
        ),

        dataColumn(
          data1: ctrl.jobData.salary.toString(), 
          title1: 'Salary', 
          money1: true,
          data2: (ctrl.jobData.salary * 1.5).toString(), 
          title2: 'Overtime', 
          money2: true,
        ),
        SizedBox(height:25.sp),
        dataColumn(
          data1: '171', 
          title1: 'Hours', 
          money1: false,
          data2: '3330', 
          title2: 'Paid', 
          money2: true
        ),

        Divider(
          height: 30.sp,
          indent: 35.sp,
          endIndent: 35.sp,
          thickness: 1.sp,
        ),

      ],)
    );
  }

  Widget dataColumn({
    String data1,
    String title1,
    bool money1 = false,
    String data2,
    String title2,
    bool money2 = false
  }){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
              new Text(money1 ? '\$ ' + data1 : data1, style: titleFont),
              new Text(title1, style: subTitleFont)
            ]),

            Column(children:[
              new Text(money2 ? '\$ ' + data2 : data2, style: titleFont),
              new Text(title2, style: subTitleFont)
            ])
        ],
      );
  }

  _buttonCards({JobCtrl ctrl}){
    return Column(
      children: [ 
        InkWell(
          onTap: ()=> Get.to(CheckinPage(), transition: Transition.zoom, arguments: ctrl.jobData),
          child: Card(
            child: ListTile(
              leading: new Icon(CupertinoIcons.checkmark_rectangle),
              title: new Text('Check entry and exit', style: subTitleFont,),
              trailing: new Icon(CupertinoIcons.chevron_right),
            ),
          )
        ),

        Card(
          child: ListTile(
            leading: new Icon(CupertinoIcons.checkmark_rectangle),
            title: new Text('Check management', style: subTitleFont,),
            trailing: new Icon(CupertinoIcons.chevron_right),
          ),
        ),

        Card(
          child: ListTile(
            leading: new Icon(CupertinoIcons.checkmark_rectangle),
            title: new Text('Summary', style: subTitleFont,),
            trailing: new Icon(CupertinoIcons.chevron_right),
          ),
        ),
      ],
    );
  }
}