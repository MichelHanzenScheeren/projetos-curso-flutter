import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/models/store.dart';
import 'package:lojavirtualflutter/app/pages/stores/storeCard.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';

class Stores extends StatelessWidget {
  final drawer;
  final cartButton;
  Stores(this.drawer, this.cartButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: cartButton,
      drawer: drawer,
      appBar: myAppBar(context),
      body: myBody(context),
    );
  }

  Widget myAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Lojas",
        style: Theme.of(context).textTheme.subtitle,
      ),
      centerTitle: true,
    );
  }

  Widget myBody(BuildContext context) {
    return FutureBuilder<List<Store>>(
      future: Database.instance.getStores(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return WaitingWidget();
        } else {
          return ListView(
            children: snapshot.data.map((doc) {
              return StoreCard(doc);
            }).toList(),
          );
        }
      },
    );
  }
}
