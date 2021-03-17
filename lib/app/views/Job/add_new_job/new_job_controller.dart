import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';
import 'package:tcp_workers/app/views/signIn/user_model.dart';

class NewJobCtrl extends GetxController{
  final box = GetStorage();
  final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  final TextEditingController name = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController address = TextEditingController();

  void setNewJob({String type})async{
    if(type == null ){
      btnController.reset();
      return MySnackBar.show(title: 'Error...', message: 'You have not selected the type of work', backgroundColor: Colors.red, icon: CupertinoIcons.multiply_circle);
    }else{
      try{
        var encode = box.read('userData');
          UserModel userData = UserModel.fromJson(json.decode(encode));
      var response = await http.post(GlobalVariables.api + '/worker/jobs/setJob'
        ,body:{
          'name' : name.text,
          'type': type,
          'salary' : salary.text,
          'address' : address.text,
          'user_employee': userData.user.id
        });
        switch (response.statusCode) {
          case 200:
            btnController.success();
            MySnackBar.show(title: 'Success!', message: 'The job has been added successfully!!', backgroundColor: Colors.green, icon: CupertinoIcons.checkmark_alt_circle);
            Timer(Duration(seconds: 3), ()=> Get.offAll(HomePage()));
          break;
          case 500:
            btnController.error();
            MySnackBar.show(title: 'Error!', message: 'Was there an error undefinied, try again or contact with support.', backgroundColor: Colors.red, icon: CupertinoIcons.multiply_circle);
            Timer(Duration(seconds: 3), ()=> btnController.reset());
          break;
          default:
            btnController.error();
            MySnackBar.show(title: 'Error!', message: 'Was there an error undefinied, try again', backgroundColor: Colors.red, icon: CupertinoIcons.multiply_circle);
            Timer(Duration(seconds: 3), ()=> btnController.reset());
        }
      }catch(err){
        print(err);
        btnController.error();
        MySnackBar.show(title: 'Error!', message: err.toString(), backgroundColor: Colors.red, icon: CupertinoIcons.multiply_circle);
        Timer(Duration(seconds: 3), ()=> btnController.reset());
      }
    }
    
  }
}