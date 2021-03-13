import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:time_range_picker/time_range_picker.dart';
import '../my_jobs/jobs_model.dart';

class CheckingCtrl extends GetxController{
  Job jobData = Get.arguments;
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  RxDouble hourWorked = 0.0.obs, payment = 0.0.obs;
  RxBool isVerifying = true.obs;
  var breakTime = 0.obs;
  final box = GetStorage();
  
  @override
  void onInit() {
    checkifTodayIsChecked();
    super.onInit();
  }

  void checkifTodayIsChecked()async{
    try{
      var response = await http.get(GlobalVariables.api + '/worker/check/verifyToday/' + jobData.id);
      switch (response.statusCode) {
        case 200:
          if(response.body == 'false'){
            isVerifying.value = false;
          }else{
            MySnackBar.show(title: 'Today has been checked!', message: 'It can only be checked once a day, come back tomorrow or you can update today\'s check', backgroundColor: Colors.orange, icon: CupertinoIcons.exclamationmark_triangle);
            Timer(Duration(seconds: 3), ()=> Get.back());
          }
        break;
        case 500:
          MySnackBar.show(title: 'Error!', message: 'There was an error checking if it was possible to check the job today, please try again', backgroundColor: Colors.red, icon: CupertinoIcons.person_crop_circle_badge_xmark);
          Timer(Duration(seconds: 3), ()=> Get.back());
        break;
        default:
        print('hay cabballo, asaber que pedo');
      }
    }catch(err){
      print(err);
    }
  }

  void calculateHoursWorked({TimeRange time}){
    if(time.endTime == null || time.startTime == null) return null;
    hourWorked.value = (toDouble(time.endTime) - toDouble(time.startTime)) - breakTime.value/60;
    payment.value = hourWorked.value * jobData.salary;
  }

  double toDouble(TimeOfDay time)=> time.hour + time.minute/60.0;

  void setCheck({TimeRange time})async{
    if(hourWorked.value == 0.0){ 
      btnController.reset();
      return MySnackBar.show(title: 'Hours worked is 0', message: 'Select the time of entry - exit and lunch time of today', backgroundColor: Colors.redAccent, icon: CupertinoIcons.xmark_circle);
    }

    try{
      final now = new DateTime.now();
      var offset = int.tryParse(DateTime.now().timeZoneOffset.toString().split(':')[0]) * -60;
      /* var userDecode = json.decode(box.read('userData'));
      UserModel user = UserModel.fromJson(userDecode); */
      var response = await http.post(GlobalVariables.api + '/worker/check/setCheck', body: 
      {
        'jobID' : jobData.id,/* 
        'userID' : user.user.id, */
        'date' : DateTime.now().toString(),
        'in' : DateTime(now.year, now.month, now.day, time.startTime.hour, time.startTime.minute).toString(),
        'out' : DateTime(now.year, now.month, now.day, time.endTime.hour, time.endTime.minute).toString(),
        'hours' : hourWorked.value.toString(),
        'break_minutes' : breakTime.value.toString(),
        'offset' : offset.toString(),
        'salary' : jobData.salary.toString(),
        'payment' : payment.value.toString()
      });
      switch (response.statusCode) {
        case 200:
          btnController.success();
          MySnackBar.show(title: 'successful check', message: 'you have successfully checked today', backgroundColor: Colors.green, icon: CupertinoIcons.checkmark_alt_circle);
          Timer(Duration(seconds: 3), ()=> Get.back());
        break;
        case 500:
          btnController.error();
          MySnackBar.show(title: 'Error!', message: 'There was an unexpected error, please try again', backgroundColor: Colors.red, icon: CupertinoIcons.person_crop_circle_badge_xmark);
          Timer(Duration(seconds: 2), ()=> btnController.reset());
        break;
        default:
        print('hay cabballo, asaber que pedo');
      }
    }catch(err){
      print(err);
      btnController.error();
      Timer(Duration(seconds: 2), ()=> btnController.reset());
    }
  }
}