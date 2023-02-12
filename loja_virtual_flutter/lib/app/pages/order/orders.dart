import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/controllerPages.dart';
import 'package:lojavirtualflutter/app/pages/order/orderItem.dart';
import 'package:lojavirtualflutter/app/pages/user/login/login.dart';
import 'package:lojavirtualflutter/app/widgets/myOkButton.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class Orders extends StatelessWidget {
  final drawer;
  final cartButton;
  Orders(this.drawer, this.cartButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      floatingActionButton: cartButton,
      appBar: myAppBar(context),
      body: ScopedModelDescendant<User>(
        builder: (context, widget, model) {
          if (!model.isLogged()) {
            return notLogged(context);
          } else if (model.isLoading) {
            return WaitingWidget();
          } else {
            return getOrderItems(context, model);
          }
        },
      ),
    );
  }

  Widget myAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Meus pedidos",
        style: Theme.of(context).textTheme.subtitle,
      ),
      centerTitle: true,
    );
  }

  Widget notLogged(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.list, size: 120),
          SizedBox(height: 10),
          Text(
            "Faça login para acompanhar seus pedidos...",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 20),
          MyOkButton("Entrar", Theme.of(context).textTheme.body1, () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Login()),
            );
          }),
        ],
      ),
    );
  }

  Widget getOrderItems(BuildContext context, User model) {
    return FutureBuilder<List<String>>(
      future: Database.instance.getOrdersUids(model.currentUser.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return WaitingWidget();
        } else {
          return buildOrderItems(context, model, snapshot.data);
        }
      },
    );
  }

  Widget buildOrderItems(
      BuildContext context, User model, List<String> orderItems) {
    if (orderItems.length == 0) {
      return ordersEmpty(context);
    } else {
      return ListView(
        children: orderItems.reversed.map((doc) {
          return Column(
            children: <Widget>[
              OrderItem(doc),
              SizedBox(height: 5),
            ],
          );
        }).toList(),
      );
    }
  }

  Widget ordersEmpty(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.playlist_add, size: 100),
          SizedBox(height: 5),
          Text(
            "Poxa, parece que você ainda não fez nenhum pedido...",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 35),
          MyOkButton(
            "Ver produtos",
            Theme.of(context).textTheme.body1,
            () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ControllerPage(),
            )),
          ),
        ],
      ),
    );
  }
}
