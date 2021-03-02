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
  String validatorText;
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
    this.validatorText,
    this.initialValue
    }) : super(key: key);
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: TextFormField(
              onChanged: widget.onChanged ,
              validator: widget.validatorText != null ? (value) {
                if (value.isEmpty) {
                  return widget.validatorText;
                }
                return null;
              } : null,
              initialValue: widget.initialValue,
              obscureText: widget.obscureText == true,
              controller: widget.controller,
              keyboardType: widget.textInputType,
              decoration: InputDecoration(
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
                      width: 2.w,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: main_color,
                    width: 2.w,
                  ),
                ),
                enabledBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: second_color,
                    width: 2.w,
                  ),
                ),
              )
            ),
        );
  }
}