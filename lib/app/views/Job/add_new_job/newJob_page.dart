import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                border: Border.all(color: typeSelected != null ? main_color : Colors.red),
                borderRadius: BorderRadius.circular(25)
              ),
              child: DropdownButton(
                hint: new Text(typeSelected ?? 'Project by: ', style: bodyFont) ,
                dropdownColor: Colors.white,
                style: subTitleFont,
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 30.sp,
                value: typeSelected,
                onChanged: (val) => setState(()=> typeSelected = val),
                items: list.map((e){
                  return DropdownMenuItem(
                    value: e,
                    child:  new Text(e),
                  );
                }).toList(),
              ),
            ),

            Input(
              width: 150.sp,
              hintText: "Salary", 
              icon: CupertinoIcons.money_dollar, 
              controller: ctrl.salary,
              textInputType: TextInputType.number,
              obscureText: false,
              validator: Validations.validateSalary,
            ),
          ],),

          new SizedBox(height: 15.sp),

          Input(
            hintText: "Address", 
            maxLines: 4,
            icon: CupertinoIcons.arrow_swap, 
            controller: ctrl.address,
            textInputType: TextInputType.text,
            obscureText: false,
            validator: Validations.validateName,
          ),

          

          Padding(
            padding: EdgeInsets.only(top:25.sp),
            child: RoundedLoadingButton(
              color: main_color,
              errorColor: Colors.red,
              successColor: Colors.green,
              child: Text('Add job', style: TextStyle(color: Colors.white)),
              controller: ctrl.btnController,
              onPressed:()=> _formKey.currentState.validate() ? ctrl.setNewJob(type: typeSelected) : ctrl.btnController.stop(),
            ),
          ),
      ],),
    );
  }
}