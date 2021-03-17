import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/variables.dart';
import 'package:tcp_workers/app/views/Home/home_page.dart';

class LoginCtrl extends GetxController{
  final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  final box = GetStorage();

  void loginWithEmail({String email, String password})async{
    try{
      var response = await http.post(GlobalVariables.api + '/worker/login',
      body: {
        'email': email,
        'password': password,
        'userType': 'em'
      });
      switch (response.statusCode) {
        case 200:
          btnController.success();
          await box.write('userData', response.body);
          Timer(Duration(seconds: 2), ()=> Get.offAll(HomePage()));
        break;
        case 500:
          btnController.error();
          MySnackBar.show(title: 'Error!', message: response.body, backgroundColor: Colors.red, icon: CupertinoIcons.person_crop_circle_badge_xmark);
          Timer(Duration(seconds: 3), ()=> btnController.reset());
        break;
        case 400:
          btnController.stop();
          MySnackBar.show(title: 'Wrong credentials', message: 'Check your credentials or you can register', backgroundColor: Colors.redAccent, icon: CupertinoIcons.person_crop_circle_badge_xmark);
          Timer(Duration(seconds: 3), ()=> btnController.reset());
        break;
        case 401:
          btnController.stop();
          MySnackBar.show(title: 'Disabled user', message: 'Contact support to reach a solution', backgroundColor: Colors.redAccent, icon: CupertinoIcons.person_crop_circle_badge_exclam);
          Timer(Duration(seconds: 3), ()=> btnController.reset());
        break;
        default:
        print('asaber');
      }
    }catch(err){
      print(err);
    }
  }
}