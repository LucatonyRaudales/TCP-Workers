import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tcp_workers/app/Style/Colors.dart';


// ignore: must_be_immutable
class Input extends StatefulWidget {
  String hintText;
  IconData icon;
  TextEditingController controller;
  TextInputType textInputType;
  bool obscureText;
  String Function(String) validator;
  String initialValue;
  void Function(String) onChanged;
  Input({
    Key key, 
    @required this.hintText, 
    this.icon, 
    this.controller, 
    @required this.textInputType,
    this.onChanged,
    this.obscureText,
    this.validator,
    this.initialValue
    }) : super(key: key);
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.sp,
      child:TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: widget.onChanged ,
        validator: widget.validator,
        initialValue: widget.initialValue,
        obscureText: widget.obscureText == true,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
          fillColor: main_color,
          labelText: widget.hintText,
          labelStyle: TextStyle(color: main_color),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: main_color),
          prefixIcon: widget.icon  != null ? Icon(widget.icon, color: main_color,) : null,
          focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: second_color,
              width: 1.w,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: main_color,
              width: 1.w,
            ),
          ),
        )
      )
    );
  }
}