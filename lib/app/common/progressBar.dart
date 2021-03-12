import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Style/Colors.dart';

class MyProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitPulse(
      color: main_color,
      size: 40.0.sp,
    );
  }
}