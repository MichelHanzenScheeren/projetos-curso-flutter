import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/cart/myCart.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 8, top: 8),
            alignment: Alignment.topLeft,
            child: Icon(Icons.shopping_cart),
          ),
          ScopedModelDescendant<User>(
            builder: (context, widget, model) {
              if (model.isLoading) {
                return Positioned(
                  right: 12,
                  bottom: 14,
                  child: Container(
                    child: WaitingWidget(height: 12, width: 12, strokeWidth: 3),
                  ),
                );
              } else {
                return Container(
                  padding: EdgeInsets.only(right: 10, bottom: 8),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "${model.cartProductsCount()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).iconTheme.color,
                      fontSize: 18,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MyCart();
        }));
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
