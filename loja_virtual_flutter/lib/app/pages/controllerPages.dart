import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/drawer/myDrawer.dart';
import 'package:lojavirtualflutter/app/pages/home/home.dart';
import 'package:lojavirtualflutter/app/pages/order/orders.dart';
import 'package:lojavirtualflutter/app/pages/products/categories.dart';
import 'package:lojavirtualflutter/app/pages/stores/stores.dart';
import 'package:lojavirtualflutter/app/widgets/cartButton.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  final pageController = PageController();
  final CartButton cartButton = CartButton();

  @override
  Widget build(BuildContext context) {
    final MyDrawer drawer = MyDrawer(pageController);

    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Home(drawer, cartButton),
        Categories(drawer, cartButton),
        Stores(drawer, cartButton),
        Orders(drawer, cartButton),
      ],
    );
  }
}
