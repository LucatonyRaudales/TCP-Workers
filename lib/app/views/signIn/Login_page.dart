import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/textFormField.dart';
import 'package:tcp_workers/app/common/validations.dart';
import 'package:tcp_workers/app/views/signUp/signup_page.dart';
import 'login_controller.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
 final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final header = new Container(
      width: Get.width / 1.5,
      child: Column(children: [
        //new Image.asset('assets/welcome.png'),
        new Text('techno construction plus'.toUpperCase(), style: titleFont, textAlign: TextAlign.center,),
        new SizedBox(height:75.ssp),
        new Text('Sign in', style: titleFont,)
      ],),
    );

  final signUpBtn = new Padding(
    padding: EdgeInsets.only(top:20.ssp),
    child: RichText(text: TextSpan(
      children:<TextSpan>[
        TextSpan(text:"Don't have an account? ", style: bodyFontBold),
        TextSpan(text: "Register Now!", style: TextStyle(fontSize: 13.ssp, color: Colors.lightBlue, fontWeight: FontWeight.bold), recognizer: new TapGestureRecognizer()..onTap = ()=> Get.to(SignUpPage()))
      ]
    ))
  ); 

    return GetBuilder<LoginCtrl>(
      init: LoginCtrl(),
      builder: (_)=> Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: background,
              child:Center(
                child: SingleChildScrollView(
                child: Form(
                  key: _formKey, 
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  header,
                  SizedBox(height: 15,),

                  Input(
                    hintText: "Email", 
                    icon: Icons.email, 
                    controller: _email, 
                    textInputType: TextInputType.emailAddress,
                    validator: Validations.validateemail,
                  ),
                  SizedBox(height: 15.0.sp),
                  Input(
                    hintText: "Password", 
                    icon: Icons.vpn_key_rounded, 
                    controller: _password,
                    textInputType: TextInputType.emailAddress,
                    validator: Validations.validatePassword,
                    obscureText: true,
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:25.sp),
                    child: RoundedLoadingButton(
                      color: main_color,
                      errorColor: second_color,
                      child: Text('Sign In', style: TextStyle(color: Colors.white)),
                      controller: _.btnController,
                      onPressed:()=> _formKey.currentState.validate() ?
                        _.loginWithEmail(email: _email.value.text, password: _password.value.text) :
                        _.btnController.stop(),
                    ),
                  ),

                  signUpBtn
                ],),
                )
            ),
          ),
          ),
          )
    )
  );
  }
}