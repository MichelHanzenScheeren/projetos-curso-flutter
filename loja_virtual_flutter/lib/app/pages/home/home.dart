import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/products/productPage.dart';
import 'package:lojavirtualflutter/app/widgets/noInternetConnection.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/widgets/degradeBack.dart';
import 'package:scoped_model/scoped_model.dart';

class Home extends StatelessWidget {
  final drawer;
  final cartButton;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Home(this.drawer, this.cartButton);

  final List<Color> colors = [
    Color.fromARGB(255, 15, 15, 15),
    Color.fromARGB(255, 30, 30, 30)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: cartButton,
      drawer: drawer,
      body: Stack(
        children: <Widget>[
          DegradeBack(colors, Alignment.topLeft, Alignment.bottomRight),
          Container(
            color: Color.fromARGB(240, 30, 30, 30),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "Novidades",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    centerTitle: true,
                  ),
                ),
                ScopedModelDescendant<User>(
                  builder: (context, widget, model) {
                    return FutureBuilder<List<DocumentSnapshot>>(
                      future: Database.instance.getHomeProducts(),
                      builder: (context, snapshot) {
                        if (!model.checkConnection())
                          return SliverToBoxAdapter(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 150),
                                NoInternetConnection()
                              ],
                            ),
                          );
                        else if (!snapshot.hasData)
                          return SliverToBoxAdapter(child: WaitingWidget());
                        return SliverStaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1,
                          staggeredTiles: snapshot.data.map((document) {
                            return StaggeredTile.count(
                                document.data["x"], document.data["y"]);
                          }).toList(),
                          children: snapshot.data.map((document) {
                            return Container(
                              padding: EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () async {
                                  await openPage(context, document.data);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Image.network(
                                      document.data["image"],
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return WaitingWidget(
                                          width: 50,
                                          height: 50,
                                        );
                                      },
                                    ),
                                    buildDescItem(context, document.data),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildDescItem(BuildContext context, Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            data["name"],
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[100],
            ),
          ),
        ],
      ),
    );
  }

  Future openPage(BuildContext context, Map<String, dynamic> data) async {
    await Database.instance
        .getProductById(data["categoryUid"], data["productUid"])
        .then((product) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return ProductPage(product);
        }),
      );
    }).catchError((error) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "Não foi possível abrir a página do produto no momento",
          style: Theme.of(context).textTheme.display1,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red[800],
      ));
    });
  }
}
