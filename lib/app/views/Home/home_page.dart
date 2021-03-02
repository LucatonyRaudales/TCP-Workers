import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/home_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (_)=> Scaffold(
        appBar: _appBar(),
        drawer: _drawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 20),
            child: new Column(
              children: [
              HomeCard(
                text: 'My jobs',
                icon: CupertinoIcons.hammer_fill,
                number: 2.toString(),
              ),

              SizedBox(height: 20.sp),

              HomeCard(
                text: 'History',
                icon: CupertinoIcons.time,
                number: 10.toString(),
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
  
  _appBar(){
    return AppBar(
      title: new Column(children:[
        Text('Techno contructions +'.toUpperCase(), style: subTitleWhiteFont),
        Text('by Techno Business Plus', style:minimalWhiteFont)
      ]),
      centerTitle: true,
      backgroundColor: main_color,
      primary: true,
      actions:[
        new IconButton(
          icon: Icon(CupertinoIcons.square_arrow_right), onPressed: ()=> print('salio'))
      ]
    );
  }

  _drawer(){
    return Drawer(
      
      semanticLabel: 'hola',
      child: new Container(
        color: Colors.transparent,
        height: Get.height,
        width: Get.width,
        child: Center(
          child: new Text('Drawer'),
        ),
      ),
    );
  }
}