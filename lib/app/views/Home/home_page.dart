import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:tcp_workers/app/common/drawer.dart';
import 'package:tcp_workers/app/common/home_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/views/Job/Job_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (_)=> Scaffold(
        appBar: MyAppBar(),
        drawer: DrawerItem(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 20),
            child: new Column(
              children: [
              HomeCard(
                text: 'My jobs',
                icon: CupertinoIcons.hammer_fill,
                number: 2.toString(),
                function: ()=> Get.to(JobPage()),
              ),

              SizedBox(height: 20.sp),

              HomeCard(
                text: 'History',
                icon: CupertinoIcons.time,
                number: 10.toString(),
                function: ()=> Get.to(JobPage()),
              ),

              SizedBox(height: 20.sp,),

              tasks()
              ],
            )
          )
        )
      )
    );
  }

  tasks(){
    return new Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(-0.5, .5), //(x,y)
            blurRadius: 2.0,
          )
        ]
      ),
      child: ExpansionTile(
        leading: new Icon(CupertinoIcons.doc_circle),
        title: new Text('Tasks', style: titleFont,),
        trailing: new Icon(CupertinoIcons.add_circled_solid),
        backgroundColor: Colors.grey[100],
        children: [
          ListTile(
            leading: new Icon(CupertinoIcons.arrow_right),
            title: new Text('Reunion todos los martes', style: bodyFont),
            onTap: ()=> print('Reunioncito'),
            hoverColor: Colors.grey[300],
          )
        ],
      ),
    );
  }
}