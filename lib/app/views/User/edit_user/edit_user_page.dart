import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/common/textFormField.dart';
import 'package:tcp_workers/app/common/validations.dart';
import 'package:tcp_workers/app/views/signIn/login_controller.dart';
import 'package:tcp_workers/app/views/signUp/signup_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/appbar.dart';
import '../../../common/validations.dart';
import '../../Job/add_new_job/newJob_page.dart';
import '../../Job/my_jobs/jobsList_controller.dart';

class EditUserPage extends StatefulWidget {
  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final RoundedLoadingButtonController btnController =
      new RoundedLoadingButtonController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController nName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'HN');
  String country = "";

  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    User user;
    user = User.fromJson(json.decode(box.read('userData')));
    fName.text = user.user.firstName;
    lName.text = user.user.lastName;
    email.text = user.user.email;
    nName.text = user.user.nickName;
    phone.text = user.user.phone;
    number = PhoneNumber(isoCode: user.user.country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actions: [
          JobsListCtrl().status == 'active'
              ? new IconButton(
                  icon: Icon(CupertinoIcons.add),
                  onPressed: () =>
                      Get.to(NewJobPage(), transition: Transition.zoom))
              : SizedBox()
        ],
      ),
      body: GetBuilder<SignUpCtrl>(
        init: SignUpCtrl(),
        builder: (_) => Scaffold(
            body: Center(
                child: SingleChildScrollView(
                    child: Container(
          child: body(ctrl: _),
        )))),
      ),
    );
  }

  Widget body({SignUpCtrl ctrl}) {
    var _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          new Text(
            'Profile',
            style: titleFont,
          ),
          new SizedBox(
            height: 25.sp,
          ),
          Input(
            hintText: "First name",
            icon: CupertinoIcons.textformat,
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
            icon: CupertinoIcons.textformat,
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
            textInputType: TextInputType.text,
            obscureText: false,
            validator: Validations.validateName,
            controller: nName,
            onChanged: (e) {
              ctrl.nName = e;
            },
          ),
          new SizedBox(
            height: 15.sp,
          ),
          Container(
            width: Get.width,
            child: InternationalPhoneNumberInput(
              inputDecoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                fillColor: main_color,
                labelStyle: bodyFont,
                hintStyle: bodyFont,
                hintText: "Phone",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: second_color,
                    width: 1.sp,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: main_color,
                    width: 1.sp,
                  ),
                ),
              ),
              onInputChanged: (PhoneNumber number) {
                country = number.isoCode;
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              formatInput: false,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              validator: Validations.validatePhone,
              textFieldController: phone,
            ),
          ),
          new SizedBox(
            height: 15.sp,
          ),
          Input(
            hintText: "Email",
            icon: CupertinoIcons.mail,
            controller: email,
            textInputType: TextInputType.text,
            obscureText: false,
            validator: Validations.validateemail,
          ),
          new SizedBox(
            height: 15.sp,
          ),
          Padding(
            padding: EdgeInsets.only(top: 25.sp),
            child: RoundedLoadingButton(
              color: main_color,
              errorColor: Colors.red,
              successColor: Colors.green,
              child: Text('Save', style: TextStyle(color: Colors.white)),
              controller: btnController,
              onPressed: () => _formKey.currentState.validate()
                  ? ctrl.saveUserData(
                      btnCtrl: btnController,
                      fName: fName.text,
                      lName: lName.text,
                      email: email.text,
                      phone: phone.text,
                      country: country,
                    )
                  : btnController.stop(),
            ),
          ),
        ],
      ),
    );
  }
}
