import 'package:animate_do/animate_do.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:tcp_workers/app/Style/Colors.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:tcp_workers/app/common/textFormField.dart';
import 'package:tcp_workers/app/common/validations.dart';
import 'package:tcp_workers/app/views/Job/add_new_job/new_job_controller.dart';

class NewJobPage extends StatefulWidget {
  @override
  _NewJobPageState createState() => _NewJobPageState();
}

class _NewJobPageState extends State<NewJobPage> {
  List list = ['hour', 'day'];
  String typeSelected;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewJobCtrl>(
      init: NewJobCtrl(),
      builder: (_){
        return Scaffold(
          appBar: MyAppBar(),
          body: new Center(
            child: new SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: _form(ctrl: _),
            ),
          ),
        );
      },
    );
  }

  Widget _form({NewJobCtrl ctrl}){
    var _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: new Column(children: [
        new Text('new job'.toUpperCase(), style: titleFont,),

        new SizedBox(height: 25.ssp),

        Input(
            hintText: "Name", 
            icon: CupertinoIcons.textformat, 
            controller: ctrl.name,
            textInputType: TextInputType.text,
            obscureText: false,
            validator: Validations.validateName,
          ),

          new SizedBox(height: 15.sp),

            Input(
              width: Get.width /2,
              hintText: "Salary", 
              icon: CupertinoIcons.money_dollar, 
              controller: ctrl.salary,
              textInputType: TextInputType.number,
              obscureText: false,
              validator: Validations.validateSalary,
            ),
          new SizedBox(height: 15.sp),
          Center(
            child: Obx(()=>CheckboxListTile(
              subtitle: Text("Select the job type", style: bodyFontBold),
                title: Text(ctrl.typeJobIsByday.value ? "By day" : "By hour", style: subTitleFontBold),
                secondary: Icon(ctrl.typeJobIsByday.value ? CupertinoIcons.sun_dust : CupertinoIcons.clock, color:main_color),
                controlAffinity: ListTileControlAffinity.trailing,
                value: ctrl.typeJobIsByday.value,
                onChanged: (bool value)=> setState(()=> ctrl.typeJobIsByday.value = value),
              )
            )
          ),
          new SizedBox(height: 15.sp),
          !ctrl.typeJobIsByday.value ? 
          FadeInDown(
            child: Obx(()=>CheckboxListTile(
                title: Text("Overtime", style: subTitleFontBold),
                subtitle: Text("Your company offers overtime?", style: bodyFontBold),
                secondary: Icon(Icons.money),
                controlAffinity: ListTileControlAffinity.platform,
                value: ctrl.overtime.value,
                onChanged: (bool value)=> ctrl.overtime.value = value,
              )
            )
          )
          : Container(),

          CSCPicker(
            onCountryChanged: (value) {
            ctrl.selectCountry(value);
          },
            ///triggers once state selected in dropdown
            onStateChanged: (value) {
              ctrl.selectState(value);
            },

            ///triggers once city selected in dropdown
            onCityChanged: (value) {
              ctrl.selectCity(value);
            },
          ),

          Padding(
            padding: EdgeInsets.only(top:25.sp),
            child: RoundedLoadingButton(
              color: main_color,
              errorColor: Colors.red,
              successColor: Colors.green,
              child: Text('Save', style: TextStyle(color: Colors.white)),
              controller: ctrl.btnController,
              onPressed:()=> _formKey.currentState.validate() ? ctrl.setNewJob() : ctrl.btnController.stop(),
            ),
          ),
      ],),
    );
  }
}