import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:tcp_workers/app/common/progressBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/views/Job/add_new_job/newJob_page.dart';
import '../Job_page.dart';
import 'jobsList_controller.dart';
import 'jobs_model.dart';

class JobsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          actions: [
            JobsListCtrl().status == 'active'
                ? new IconButton(
                    icon: Icon(CupertinoIcons.add),
                    onPressed: () =>
                        Get.to(NewJobPage(), transition: Transition.zoom))
                : SizedBox()
          ],
        ),
        body: GetBuilder<JobsListCtrl>(
          init: JobsListCtrl(),
          builder: (_ctrl) {
            return Container(
                child: _ctrl.jobList != null && _ctrl.jobList.jobList.isNotEmpty
                    ? new ListView.builder(
                        itemCount: _ctrl.jobList.jobList.length,
                        itemBuilder: (context, index) {
                          return jobCard(job: _ctrl.jobList.jobList[index]);
                        },
                      )
                    : JobsListCtrl().status == 'active'
                        ? Center(
                            child: new Text(
                                'press the (+) icon to add a new job',
                                style: titleFont))
                        : Center(
                            child: new Text('No data to display...',
                                style: titleFont)));
          },
        ));
    /*FutureBuilder<List<Job>>(
        future:JobsListCtrl().getJobsList(),
        builder:(context, snapshot){
          if(snapshot.hasData){
          List<Job> listData = snapshot.data;
            
            return listData.length > 0 ? new ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index){
                  return jobCard(job: listData[index]);
                },
            ) :
            JobsListCtrl().status == 'active' ? 
            Center(
              child: new Text('press the (+) icon to add a new job', style: titleFont)
            )
            :
            Center(
              child: new Text('No data to display...', style: titleFont)
            )
            ;
          }
          return Center(
            child: MyProgressBar(),
          );
    );*/
  }

  Widget jobCard({Job job}) {
    return new InkWell(
        onTap: () {
          Get.to(() => JobPage(),
              transition: Transition.rightToLeftWithFade, arguments: job);
        },
        child: new Card(
          margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: main_color,
              radius: 25,
              child: new Icon(
                job.type == 'day'
                    ? CupertinoIcons.sun_min
                    : CupertinoIcons.time,
                color: Colors.white,
              ),
            ),
            title: new Text(
              job.name,
              style: titleFont,
            ),
            subtitle: new Text(
              'By: ' + job.type,
              style: subTitleFontBold,
            ),
            trailing: new Icon(CupertinoIcons.chevron_right),
          ),
        ));
  }
}
