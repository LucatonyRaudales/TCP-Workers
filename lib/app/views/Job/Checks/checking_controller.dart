import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';
import 'package:time_range_picker/time_range_picker.dart';

class CheckingCtrl extends GetxController{
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  RxDouble hourWorked = 0.0.obs;
  var breakTime = 0.obs;
  @override
  void onInit() {
    print('checking controller initializated!');
    super.onInit();
  }

  void calculateHoursWorked({TimeRange time}){
    if(time.endTime == null || time.startTime == null) return null;
    hourWorked.value = (toDouble(time.endTime) - toDouble(time.startTime)) - breakTime.value/60;
    print(hourWorked.value);
  }

  double toDouble(TimeOfDay time)=> time.hour + time.minute/60.0;

  void setCheck({TimeRange time})async{
    if(hourWorked.value == 0.0){ 
      btnController.reset();
      return MySnackBar.show(title: 'Hours worked is 0', message: 'Select the time of entry - exit and lunch time of today', backgroundColor: Colors.redAccent, icon: CupertinoIcons.xmark_circle);
    }

    try{
      var offset = int.tryParse(DateTime.now().timeZoneOffset.toString().split(':')[0]) * 60;
      var response = await http.post(GlobalVariables.api + '', body: 
      {
        'date' : DateTime.now().toString(),
        'in' : time.startTime,
        'out' : time.endTime,
        'hours' : hourWorked.value.toString(),
        'break_minutes' : breakTime.value.toString(),
        'offset' : offset.toString(),
        'salary' : 'salary'
      });

      switch (response.statusCode) {
        case 200:
          print('bien hecho');
          MySnackBar.show(title: 'successful check', message: 'you have successfully checked today', backgroundColor: Colors.green, icon: CupertinoIcons.checkmark_alt_circle);
        break;
        case 500:
          btnController.error();
          MySnackBar.show(title: 'Error!', message: 'There was an unexpected error, please try again', backgroundColor: Colors.red, icon: CupertinoIcons.person_crop_circle_badge_xmark);
        break;
        default:
        print('hay cabballo, asaber que pedo');
      }
    }catch(err){
      print(err);
    }
          
    Timer(Duration(seconds: 2), (){
    print('checado mi papasito');
    Get.off(HomePage());
    });
  }
}