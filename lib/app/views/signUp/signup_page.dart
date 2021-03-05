import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/textFormField.dart';
import 'package:tcp_workers/app/views/signUp/signup_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();

class SignUpPage extends StatelessWidget {
  final RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpCtrl>(
      init: SignUpCtrl(),
      builder: (_)=> Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: body(ctrl: _),
            )
          )
        )
      ),
    );
  }

  Widget body({SignUpCtrl ctrl}){
    return FormField(
      builder: (FormFieldState formFieldState){
        return new Column(children: [
          new Text('Sign up', style: titleFont,),

          new SizedBox(height: 25.sp,),

          Input(
            hintText: "First name", 
            icon: CupertinoIcons.person_alt_circle, 
            controller: fName,
            textInputType: TextInputType.text,
            obscureText: false,
            validator: ctrl.validateName,
          ),

          new SizedBox(height: 15.sp,),

          Input(
            hintText: "Last name", 
            icon: CupertinoIcons.person_alt_circle, 
            controller: lName,
            textInputType: TextInputType.text,
            obscureText: false,
            validator: ctrl.validateName,
          ),

          new SizedBox(height: 15.sp,),

          Input(
            hintText: "Nick name", 
            icon: CupertinoIcons.person_alt_circle, 
            onChanged:(val){
              ctrl.nName = val;
              val != '' ?
              ctrl.verifyNickName(nick: val)
              : print('vacio');
            },
            textInputType: TextInputType.text,
            obscureText: false,
            validator: ctrl.validateName,
          ),

          new SizedBox(height: 15.sp,),

          Input(
            hintText: "Email", 
            icon: CupertinoIcons.envelope, 
            controller: email,
            textInputType: TextInputType.emailAddress,
            obscureText: false,
            validator: ctrl.validateemail,
          ),

          new SizedBox(height: 15.sp,),

          Input(
            hintText: "Password", 
            icon: Icons.vpn_key_rounded, 
            controller: password,
            textInputType: TextInputType.emailAddress,
            obscureText: true,
          ),

          Padding(
            padding: EdgeInsets.only(top:25.sp),
            child: RoundedLoadingButton(
              color: main_color,
              errorColor: Colors.red,
              successColor: Colors.green,
              child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              controller: btnController,
              onPressed:()=> ctrl.signUp(
                fName: fName.value.text,
                lName: lName.value.text,
                email: email.value.text,
                password: password.value.text,
                btnCtrl: btnController
              ),
                        ),
                      ),
        ],);
      },
    );
  }
}