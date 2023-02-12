import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/models/product.dart';
import 'package:lojavirtualflutter/app/pages/products/productPage.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';

class ProductItem extends StatelessWidget {
  final String type;
  final Product product;
  ProductItem(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductPage(product)));
      },
      child: Card(
        color: Colors.transparent,
        child: type == "grid" ? gridItem(context) : listItem(context),
      ),
    );
  }

  Widget gridItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.9,
          child: Image.network(
            product.images[0],
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return WaitingWidget(width: 10, height: 10);
              }
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  "R\$${product.price.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.display2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget listItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
            height: 250,
          ),
        ),
        Flexible(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    Text(
                      "R\$${product.price.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ],
                ))),
      ],
    );
  }
}
