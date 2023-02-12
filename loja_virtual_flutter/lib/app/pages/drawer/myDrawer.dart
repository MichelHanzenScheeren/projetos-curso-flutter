import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/drawer/drawerItem.dart';
import 'package:lojavirtualflutter/app/pages/user/login/login.dart';
import 'package:lojavirtualflutter/app/widgets/degradeBack.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class MyDrawer extends StatelessWidget {
  final PageController pageController;
  MyDrawer(this.pageController);

  final List<Color> colors = [
    Color.fromARGB(255, 40, 40, 40),
    Color.fromARGB(255, 30, 30, 30),
    Color.fromARGB(255, 20, 20, 20)
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          DegradeBack(colors, Alignment.topCenter, Alignment.bottomCenter),
          Container(
            color: Colors.transparent,
            child: ListView(
              padding: EdgeInsets.only(left: 35, top: 60),
              children: <Widget>[
                Container(
                  height: 160,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          "Mixéus'\nTechnologies",
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<User>(
                          builder: (context, widget, model) {
                            return userRegion(model, context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: <Widget>[
                      DrawerItem(Icons.home, "Início", pageController, 0),
                      DrawerItem(Icons.list, "Produtos", pageController, 1),
                      DrawerItem(Icons.location_on, "Lojas", pageController, 2),
                      DrawerItem(Icons.playlist_add_check, "Meus pedidos",
                          pageController, 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userRegion(User model, BuildContext context) {
    if (model.isLoading) return WaitingWidget(width: 50, height: 50);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          model.isLogged() ? "Olá, ${model.getName()}!" : "Bem-vindo!",
          style: Theme.of(context).textTheme.body1,
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            model.isLogged() ? model.logOut() : openPage(context);
          },
          child: Text(
            model.isLogged() ? "Sair da conta >" : "Entre ou cadastre-se >",
            style: Theme.of(context).textTheme.body2,
          ),
        ),
      ],
    );
  }

  void openPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
