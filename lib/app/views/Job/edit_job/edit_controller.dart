import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/views/Job/my_jobs/jobs_model.dart';

import '../job_controller.dart';

class EditJobCtrl extends GetxController{
  final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  Job jobData = Get.arguments;  
  String country;
  String state;
  String city;

  void selectCountry(String va){
    country = va;
  }
  void selectState(String va){
    state = va;
  }
  void selectCity(String va){
    city = va;
  }

  void updateJob()async{
    print(jobData.address.state);
    try{
      var response = await http.put(GlobalVariables.api + '/worker/jobs/updatejob',
      body: {
          'name' : jobData.name,
          'type': jobData.type,
          'salary' : jobData.salary.toString(),
          'address' : json.encode({'state' : jobData.address.state, 'city':jobData.address.city}),
        });
      switch(response.statusCode){
        case 200:
          Get.put(JobCtrl());
          JobCtrl inst = Get.find();
          inst.jobData = jobData;
          MySnackBar.show(title: 'Susccess', message: 'You are updated ${jobData.name} job', backgroundColor: Colors.green, icon: CupertinoIcons.check_mark_circled);
          btnController.success();
          Timer(Duration(seconds: 3), ()=> Get.back());
        break;
        case 500:
          MySnackBar.show(title: 'Error!', message: 'There was an unexpected error, please try again', backgroundColor: Colors.red, icon: CupertinoIcons.xmark_circle);
          btnController.error();
          Timer(Duration(seconds: 3), ()=> btnController.reset());
        break;
        default:
        print('sepa mi ciela hermosa linda');
      }
    }catch(err){
      print(err);
    }
  }
}