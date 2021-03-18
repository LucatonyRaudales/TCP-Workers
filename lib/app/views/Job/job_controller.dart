import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';
import 'my_jobs/jobs_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobCtrl extends GetxController{
  Job jobData = Get.arguments;
  RxBool showButton = false.obs;
  final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();

  @override
  void onInit() {
    print('job controller');
    print(jobData.name);
    print(jobData.status);
    super.onInit();
  }

  void getJobData()async{
    try{

    }catch(err){
      print(err);
    }
  }

  void markAsFinished()async{
    try{
          var res = await http.put(GlobalVariables.api + '/worker/jobs/changeStatusJob',
          body:{
            'jobID' : jobData.id,
            'status' : 'finished'
          }
          );
          print(res.statusCode);
          switch (res.statusCode) {
            case 200:
              print('bien hecho');
              btnController.success();
              Timer(Duration(seconds: 2,), ()=> Get.to(HomePage(), transition: Transition.leftToRightWithFade));
            break;
            case 500:
              btnController.error();
              MySnackBar.show(title: 'Error!', message: res.body, backgroundColor: Colors.red, icon: CupertinoIcons.xmark_octagon_fill);
              Timer(Duration(seconds: 3,), ()=> btnController.reset());
            break;
            default:
              btnController.error();
              MySnackBar.show(title: 'Error!', message: 'There was an unexpected error, please try again', backgroundColor: Colors.red, icon: CupertinoIcons.xmark_octagon_fill);
              Timer(Duration(seconds: 3,), ()=> btnController.reset());
            break;
          }
    }catch(err){

    }
  }
}