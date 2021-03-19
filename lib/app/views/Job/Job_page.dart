import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/views/Job/summary/summary_page.dart';
import 'Checks/check_management/check_manage_page.dart';
import 'Checks/checking/checking_page.dart';
import 'edit_job/edit_page.dart';
import 'job_controller.dart';

class JobPage extends StatelessWidget {
  const JobPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<JobCtrl>(
      init: JobCtrl(),
      builder: (ctrl)=> Scaffold(
        appBar: MyAppBar(actions: [
          PopupMenuButton(
                color: Colors.white,
                elevation: 20,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onSelected: (value) {
                  switch(value){
                    case 0:
                    Get.to(EditJobPage(), arguments: ctrl.jobData, transition: Transition.rightToLeftWithFade);
                    break;
                    case 1:
                      ctrl.showButton.value = true;
                    break;
                    case 2:
                      ctrl.showButton.value = false;
                    break;
                    default:
                    print('sepa mi ciela $value');
                  }
                },
                itemBuilder:(context) =>  [
                  PopupMenuItem(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Edit", style: subTitleFont,), Icon(CupertinoIcons.pencil, color: main_color, size: 25.sp,),],),
                    value: 0,
                  ),

                  ctrl.jobData.status == 'active' ?
                  PopupMenuItem(
                    enabled: ctrl.jobData.status == 'active' && ctrl.showButton.value == false,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Mark as finished", style: subTitleFont,), Icon(CupertinoIcons.tag, color: main_color, size: 25.sp,),],),
                    value: 1,
                  ) : null,

                  ctrl.jobData.status == 'active' ?
                  PopupMenuItem(
                    enabled: ctrl.showButton.value,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Cancel", style: subTitleFont,), Icon(CupertinoIcons.xmark, color: main_color, size: 25.sp,),],),
                    value: 2,
                  ) : null,
                ]
            )
      //new IconButton(icon: Icon(CupertinoIcons.checkmark_seal), onPressed: ()=>  ctrl.markAsFinished())
    ]),
        body:SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.ssp),
            child: new Column(children: [
              dataView(ctrl: ctrl),
              _buttonCards(ctrl: ctrl)
            ],),
          ),
        ))
      );
  }

  Widget dataView({JobCtrl ctrl}){
    return new Container(
      width: Get.width,
      child: Column(
        children: [
          Icon(ctrl.jobData.type == 'day' ? CupertinoIcons.sun_dust : CupertinoIcons.clock , color: main_color, size: 55.sp),
          SizedBox(height: 20.sp,),
          new Text(ctrl.jobData.name.toUpperCase(), style: titleFont),
          SizedBox(height: 10.sp,),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            new Text('${ctrl.jobData.address.city}, ${ctrl.jobData.address.state}', style: subTitleFont),

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

        ctrl.jobData.status == 'active' ?
        checksOptions(ctrl: ctrl)
        : 
        new Text('This job has been marked as finished', style: subTitleFontBold),
        
        SizedBox(height: 5.sp,),

        InkWell(
          onTap: ()=> Get.to(SummaryPage(), transition: Transition.zoom, arguments: ctrl.jobData),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            child: ListTile(
              leading: new Icon(CupertinoIcons.calendar),
              title: new Text('Summary', style: subTitleFont,),
              trailing: new Icon(CupertinoIcons.chevron_right),
            ),
          ),
        ),

        SizedBox(height: 25.sp,),

        Obx(() =>ctrl.showButton.value ?
        FadeInUp(
          child:RoundedLoadingButton(
            color: Colors.red,
            errorColor: Colors.red,
            successColor: Colors.green,
            child: Text('Yes!, I want to mark the job as finished.', style: TextStyle(color: Colors.white)),
            controller: ctrl.btnController,
            onPressed:()=> ctrl.markAsFinished(),
          )
        )
        : SizedBox(height:5)
        )
      ],
    );
  }

  Widget checksOptions({JobCtrl ctrl}){
    return Column(
      children: [
        InkWell(
          onTap: ()=> Get.to(CheckinPage(), transition: Transition.zoom, arguments: ctrl.jobData),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            child: ListTile(
              leading: new Icon(CupertinoIcons.checkmark_rectangle),
              title: new Text('Check entry and exit', style: subTitleFont,),
              trailing: new Icon(CupertinoIcons.chevron_right),
            ),
          )
        ),

    SizedBox(height: 5.sp,),

    InkWell(
      onTap: ()=> Get.to(CheckManagementPage(), transition: Transition.zoom, arguments: ctrl.jobData),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: ListTile(
          leading: new Icon(CupertinoIcons.gear_alt),
          title: new Text('Check management', style: subTitleFont,),
          trailing: new Icon(CupertinoIcons.chevron_right),
        ),
      )
    )
      ],
    );
  }
}