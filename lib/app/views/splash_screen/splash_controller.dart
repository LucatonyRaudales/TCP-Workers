import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tcp_workers/app/views/signIn/Login_page.dart';
import 'package:tcp_workers/app/views/signUp/signup_page.dart';

class SplashCtrl extends GetxController{
  final box = GetStorage();

  @override
  void onInit() {
    print('splash ctrl initializated');
    verifyIsLogin();
    super.onInit();
  }

  void verifyIsLogin(){
    (box.read('userData') != null  && box.read('userToken')  != null )
    ?
    Timer(Duration(seconds: 2), ()=> Get.to(SignInPage(), transition: Transition.fadeIn))
    :
    box.remove('userData');
    box.remove('userToken');
    Timer(Duration(seconds: 2), ()=> Get.to(SignUpPage(), transition: Transition.leftToRightWithFade))
    ;
  }
}