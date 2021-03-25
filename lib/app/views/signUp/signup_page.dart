import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/snackbar.dart';
import 'package:tcp_workers/app/common/textFormField.dart';
import 'package:tcp_workers/app/common/validations.dart';
import 'package:tcp_workers/app/views/signUp/signup_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcp_workers/app/views/Terminos y Condiciones/F&Q.dart';

class SignUpPage extends StatelessWidget {
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpCtrl>(
      init: SignUpCtrl(),
      builder: (_) => Scaffold(
          body: Center(
              child: SingleChildScrollView(
                  child: Container(
        child: body(ctrl: _),
      )))),
    );
  }

  Widget body({SignUpCtrl ctrl}) {
    var _formKey = GlobalKey<FormState>();
    RxBool terminos = false.obs;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          new Text(
            'Sign up',
            style: titleFont,
          ),
          new SizedBox(
            height: 25.sp,
          ),
          Input(
            hintText: "First name",
            icon: CupertinoIcons.person_alt_circle,
            controller: fName,
            textInputType: TextInputType.text,
            obscureText: false,
            validator: Validations.validateName,
          ),
          new SizedBox(
            height: 15.sp,
          ),
          Input(
            hintText: "Last name",
            icon: CupertinoIcons.person_alt_circle,
            controller: lName,
            textInputType: TextInputType.text,
            obscureText: false,
            validator: Validations.validateName,
          ),
          new SizedBox(
            height: 15.sp,
          ),
          Input(
            hintText: "Nick name",
            icon: CupertinoIcons.person_alt_circle,
            onChanged: (val) {
              ctrl.nName = val;
            },
            textInputType: TextInputType.text,
            obscureText: false,
            validator: Validations.validateName,
          ),
          new SizedBox(
            height: 15.sp,
          ),
          Input(
            hintText: "Email",
            icon: CupertinoIcons.envelope,
            controller: email,
            textInputType: TextInputType.emailAddress,
            obscureText: false,
            validator: Validations.validateemail,
          ),
          new SizedBox(
            height: 15.sp,
          ),
          Input(
            hintText: "Password",
            icon: Icons.vpn_key_rounded,
            controller: password,
            textInputType: TextInputType.emailAddress,
            obscureText: true,
            validator: Validations.validatePassword,
          ),
          new SizedBox(
            height: 15.sp,
          ),
          Row(
            children: [
              Obx(
                () => Checkbox(
                  value: terminos.value,
                  onChanged: (e) {
                    terminos.value = e;
                  },
                  activeColor: main_color,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Agree ",
                      style: TextStyle(
                        fontSize: 13.ssp,
                        color: main_color,
                      ),
                    ),
                    TextSpan(
                      text: "Terms and Conditions",
                      style: TextStyle(
                          fontSize: 13.ssp,
                          color: main_color,
                          fontWeight: FontWeight.bold),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => Get.to(TermsandConditions()),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.sp),
            child: RoundedLoadingButton(
              color: main_color,
              errorColor: Colors.red,
              successColor: Colors.green,
              child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              controller: btnController,
              onPressed: () {
                _formKey.currentState.validate() == true
                    ? terminos.value
                        ? ctrl.signUp(
                            fName: fName.value.text,
                            lName: lName.value.text,
                            email: email.value.text,
                            password: password.value.text,
                            btnCtrl: btnController)
                        : MySnackBar.show(
                            title: 'terms and Conditions ',
                            message: 'Please accept the terms to continue',
                            backgroundColor: Colors.redAccent,
                            icon: CupertinoIcons.clear_thick)
                    : btnController.stop();
                if (!terminos.value) {
                  btnController.stop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
