import 'package:appanimacoescomplexas/app/pages/home/widgets/categoryRow.dart';
import 'package:appanimacoescomplexas/app/themes/myTheme.dart';
import 'package:flutter/material.dart';

class HomeTop extends StatelessWidget {
  final Animation<double> animation;
  final String username;
  HomeTop({@required this.animation, @required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/home.gif"), fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Bem-vindo, $username!",
                style: myHomeTitleTextStyle()
                    .copyWith(fontSize: animation.value * 24),
              ),
            ),
            userCircle(),
            CategoryRow(animation),
          ],
        ),
      ),
    );
  }

  Widget userCircle() {
    return Container(
      alignment: Alignment.topRight,
      width: animation.value * 120,
      height: animation.value * 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(76, 43, 136, 0.9),
        image: DecorationImage(
          image: AssetImage("images/home_user.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: animation.value * 35,
        height: animation.value * 35,
        decoration: BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
        child: Text("2",
            style: myHomeTitleTextStyle()
                .copyWith(fontSize: animation.value * 16)),
      ),
    );
  }
}
