import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';

class SignUpCtrl extends GetxController{
  String nName;
  bool isconnecting = false;
  bool nickIsUsed = true;

@override
  void onInit() {
    print(GlobalVariables.api);
    super.onInit();
  }

  String validateemail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void verifyNickName({String nick})async{
    try {
      var response = await http.get(GlobalVariables.api + "/worker/verifyUserName/$nick");
      print(response.body);
      switch (response.body) {
        case 'true':
          nickIsUsed = true;
        break;
        case 'false':
          nickIsUsed = false;
        break;
        default:
        print('no se que onda my friend');
        break;
      }
    } catch (e) {
    }
  }

  void signUp({String fName, String lName, String email, String password, RoundedLoadingButtonController btnCtrl})async{
    try{
      var response = await http.post(GlobalVariables.api + '/worker/signup',
      body: {
        'firstName' : fName,
        'lastName' : lName,
        'nickName' : nName,
        'email' : email,
        'password' : password
      });
      switch (response.statusCode) {
        case 200:
          btnCtrl.success();
          MySnackBar.show(title: 'Welcome!', message: 'You are a new user $fName!...', backgroundColor: Colors.green, icon: CupertinoIcons.person_crop_circle_badge_checkmark);
          Timer(Duration(seconds: 3), ()=> Get.to(HomePage()));
        break;
        case 500:
          btnCtrl.error();
          MySnackBar.show(title: 'Error!', message: response.body, backgroundColor: Colors.red, icon: CupertinoIcons.person_crop_circle_badge_xmark);
          Timer(Duration(seconds: 3), ()=> btnCtrl.reset());
        break;
        case 402:
          btnCtrl.stop();
          MySnackBar.show(title: 'Info!', message: 'the email already exists in our database', backgroundColor: main_color, icon: CupertinoIcons.person_crop_circle_badge_exclam);
          Timer(Duration(seconds: 3), ()=> btnCtrl.reset());
        break;
        default:
        print('asaber');
      }
    }catch(e){
      print(e);
    }
  }

  void saveUserData()async{

  }
}