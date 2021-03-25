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

import 'edit_controller.dart';

class EditJobPage extends StatefulWidget {
  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  List list = ['hour', 'day'];
  String typeSelected;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditJobCtrl>(
      init: EditJobCtrl(),
      builder: (_) {
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

  Widget _form({EditJobCtrl ctrl}) {
    var _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Container(
        width: 500,
        child: new Column(
          children: [
            new Text(
              'Edit ${ctrl.jobData.name}'.toUpperCase(),
              style: titleFont,
            ),
            new SizedBox(height: 25.ssp),
            Input(
              hintText: "Name",
              icon: CupertinoIcons.textformat,
              initialValue: ctrl.jobData.name,
              onChanged: (val) => ctrl.jobData.name = val,
              textInputType: TextInputType.text,
              obscureText: false,
              validator: Validations.validateName,
            ),
            new SizedBox(height: 15.sp),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  decoration: BoxDecoration(
                      border: Border.all(color: main_color),
                      borderRadius: BorderRadius.circular(5)),
                  child: DropdownButton(
                    hint: new Text(typeSelected ?? 'Project by: ',
                        style: bodyFont),
                    dropdownColor: Colors.white,
                    style: subTitleFont,
                    elevation: 5,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30.sp,
                    value: typeSelected ?? ctrl.jobData.type,
                    onChanged: (val) => setState(() {
                      typeSelected = val;
                      ctrl.jobData.type = val;
                    }),
                    items: list.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: new Text(e),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Input(
                    onChanged: (val) => ctrl.jobData.salary = int.tryParse(val),
                    hintText: "Salary",
                    icon: CupertinoIcons.money_dollar,
                    initialValue: ctrl.jobData.salary.toString(),
                    textInputType: TextInputType.number,
                    obscureText: false,
                    validator: Validations.validateSalary,
                  ),
                ),
              ],
            ),
            new SizedBox(height: 15.sp),
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
              padding: EdgeInsets.only(top: 25.sp),
              child: RoundedLoadingButton(
                color: main_color,
                errorColor: Colors.red,
                successColor: Colors.green,
                child: Text('edit job', style: TextStyle(color: Colors.white)),
                controller: ctrl.btnController,
                onPressed: () => _formKey.currentState.validate()
                    ? ctrl.updateJob()
                    : ctrl.btnController.stop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
