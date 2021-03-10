import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/common/select.dart';
import 'package:tcp_workers/app/views/Job/add_new_job/newJob_page.dart';

class DrawerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          height: Get.height,
          padding: EdgeInsets.symmetric(
            horizontal: 5.ssp,
            vertical: 25.ssp
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[ 

            new Text('Techno construction plus'.toUpperCase(), style: titleFont, textAlign: TextAlign.center),
            
            new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            _drawerItem(
              function: ()=> Get.back(),
              icon:  CupertinoIcons.home,
              text: 'Home'
            ),

            SizedBox(height: 15.ssp),

            SizedBox(height: 15.ssp),
            _drawerItem(
              function: ()=> Get.to(NewJobPage()),
              icon:  CupertinoIcons.cloud_sun_fill,
              text: 'New job'
            ),

          ]
        ),
            _drawerItem(
              function: ()=> Get.to(MySelect()),
              icon:  CupertinoIcons.escape,
              text: 'Logout'
            ),
          ]
          )
          )
      )
    );
  }


  Widget _drawerItem({
    Function function,
    IconData icon,
    String text,
  }){
    return new InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10.ssp)),
          splashColor: second_color,
          onTap: function,
          child:Container(
            padding: EdgeInsets.symmetric(vertical: 5.ssp, horizontal:10.ssp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.ssp)),
              border: Border.all(width: 1.ssp, color: main_color)
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                new Icon(icon, size: 15.ssp, color: main_color,),
                new Text(text, style: subTitleFont),
                new Icon(Icons.arrow_forward_ios_rounded, color: main_color,)
              ],)
          ),
        );
  }
}