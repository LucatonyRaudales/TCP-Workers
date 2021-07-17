import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:tcp_workers/app/common/drawer.dart';
import 'package:tcp_workers/app/common/home_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/common/progressBar.dart';
import 'package:tcp_workers/app/views/Job/my_jobs/jobList_page.dart';
import 'package:tcp_workers/app/views/chat/conversations_page/chats_page.dart';
import 'package:tcp_workers/app/views/splash_screen/splash_page.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = GetStorage();
  void logout() async {
    await box.erase();
    Get.off(SplashPage(), transition: Transition.fade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actions: [
          new IconButton(
            icon: Icon(Icons.message_outlined),
            onPressed: () => Get.to(()=> ChatPage())
          ),
          new IconButton(
            icon: Icon(CupertinoIcons.square_arrow_right),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: main_color,
                content: const Text(
                  'Sure you want to log out?',
                ),
                action: SnackBarAction(
                  onPressed: () => logout(),
                  label: 'Yes!',
                  textColor: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
      drawer: DrawerItem(),
      body: FutureBuilder<dynamic>(
        future: HomeCtrl().getDataHomePage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 20),
                child: new Column(
                  children: [
                    HomeCard(
                      text: 'My jobs',
                      icon: CupertinoIcons.hammer_fill,
                      number: snapshot.data['myJobs'],
                      function: () =>
                          Get.to(JobsListPage(), arguments: 'active'),
                    ),
                    SizedBox(height: 20.sp),
                    HomeCard(
                      text: 'History',
                      icon: CupertinoIcons.time,
                      number: snapshot.data['history'],
                      function: () =>
                          Get.to(JobsListPage(), arguments: 'finished'),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                   // tasks()
                  ],
                ),
              ),
            );
          }
          return MyProgressBar();
        },
      ),
    );
  }

  tasks() {
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
          ]),
      child: ExpansionTile(
        leading: new Icon(CupertinoIcons.doc_circle),
        title: new Text(
          'Tasks',
          style: titleFont,
        ),
        trailing: new Icon(CupertinoIcons.add_circled_solid),
        backgroundColor: Colors.grey[100],
        children: [
          ListTile(
            leading: new Icon(CupertinoIcons.arrow_right),
            title: new Text('Reunion todos los martes', style: bodyFont),
            onTap: () => print('Reunioncito'),
            hoverColor: Colors.grey[300],
          )
        ],
      ),
    );
  }
}
