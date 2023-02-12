import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/pages/products/categoryItem.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';

class Categories extends StatelessWidget {
  final drawer;
  final cartButton;
  Categories(this.drawer, this.cartButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: cartButton,
      drawer: drawer,
      appBar: AppBar(
        title: Text(
          "Produtos",
          style: Theme.of(context).textTheme.subtitle,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: Database.instance.getProductsCategories(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return WaitingWidget();
          } else {
            return ListView(
              children: ListTile.divideTiles(
                tiles: snapshot.data.map((category) {
                  return CategoryButton(category);
                }).toList(),
                color: Colors.grey[700],
              ).toList(),
            );
          }
        },
      ),
    );
  }
}
