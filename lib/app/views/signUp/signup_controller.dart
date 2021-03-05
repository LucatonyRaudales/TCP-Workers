import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
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
  final box = GetStorage();

@override
  void onInit() {
    print(GlobalVariables.api);
    super.onInit();
  }

  Future<bool> validateNickName(String nick)async{
    try {
      var response;
      response = await http.get(GlobalVariables.api + "/worker/verifyUserName/$nick");
          switch (response.body) {
          case 'true':
            return true;
          break;
          default:
            return false;
          break;
        }
    } catch (e) {
      return null;
    }
  }

  void signUp({String fName, String lName, String email, String password, RoundedLoadingButtonController btnCtrl})async{
    try{
      bool nickIsUsed =  await validateNickName(nName);
      if(nickIsUsed){
      btnCtrl.stop();
      return MySnackBar.show(
        title: 'Nickname is used', 
        message: 'The nickname $nName is already used, choose another one!...', 
        backgroundColor: main_color, 
        icon: CupertinoIcons.person_crop_circle_fill_badge_xmark
      );
      }
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
          var decode = json.decode(response.body);
          await box.write('userData', decode['user']);
          await box.write('userToken', decode['token']);
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