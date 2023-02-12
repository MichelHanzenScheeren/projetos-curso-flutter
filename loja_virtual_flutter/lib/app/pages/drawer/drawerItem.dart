import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;
  DrawerItem(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: Container(
          height: 70,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: page == pageController.page.round()
                    ? Colors.blueAccent
                    : Theme.of(context).hintColor,
              ),
              SizedBox(width: 20),
              Text(
                text,
                style: page == pageController.page.round()
                    ? Theme.of(context).textTheme.body2
                    : Theme.of(context).textTheme.body1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
