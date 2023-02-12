import 'package:appanimacoescomplexas/app/themes/myTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginButton extends StatelessWidget {
  final Function doLogin;
  final AnimationController controller;
  final Animation<double> buttonToLoading;
  final Animation<double> buttonZoomOut;
  LoginButton(this.doLogin, this.controller)
      : buttonToLoading = Tween(begin: 320.0, end: 65.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.1),
          ),
        ),
        buttonZoomOut = Tween(begin: 65.0, end: 1000.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.7, 1, curve: Curves.fastOutSlowIn),
          ),
        );

  @override
  Widget build(BuildContext context) {
    //timeDilation = 10;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (buttonZoomOut.value == 65) {
          return Container(
            margin: EdgeInsets.only(bottom: 35),
            height: 65,
            width: buttonToLoading.value,
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30),
              color: Color.fromRGBO(76, 43, 136, 0.8),
              child: buttonToLoading.value > 200
                  ? MaterialButton(
                      padding: EdgeInsets.all(20),
                      onPressed: doLogin,
                      child: Text("ENTRAR", style: myButtonTextStyle()),
                    )
                  : Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white70),
                        strokeWidth: 3,
                      ),
                    ),
            ),
          );
        } else {
          return Hero(
            tag: "fade",
            child: Container(
              height: buttonZoomOut.value,
              width: buttonZoomOut.value,
              color: Color.fromRGBO(76, 43, 136, 1),
            ),
          );
        }
      },
    );
  }
}
