import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tcp_workers/app/Style/text.dart';
import 'package:tcp_workers/app/views/splash_screen/splash_controller.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashCtrl>(
      init: SplashCtrl(),
      builder: (_) => Scaffold(
        body: SafeArea(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SlideInDown(
                child: Text('Techno Construction Plus "Workers"',
                    textAlign: TextAlign.center, style: titleFont),
              ),
              FadeInLeftBig(
                  child: new Text(
                'by techno business plus',
                style: bodyFont,
                textAlign: TextAlign.center,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
