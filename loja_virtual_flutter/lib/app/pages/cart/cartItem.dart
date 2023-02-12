import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/models/cartProduct.dart';
import 'package:lojavirtualflutter/app/pages/products/productPage.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';

class CartItem extends StatelessWidget {
  final CartProduct cartProduct;
  CartItem(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.transparent,
      child: cartProduct.product == null
          ? FutureBuilder(
              future: User.of(context).cart.getProductById(cartProduct),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                    height: 150,
                    child: WaitingWidget(height: 30, width: 30),
                  );
                } else {
                  return buildItem(context);
                }
              },
            )
          : buildItem(context),
    );
  }

  Widget buildItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductPage(cartProduct.product),
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                cartProduct.product.images[0],
                fit: BoxFit.cover,
                height: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return WaitingWidget(width: 120, height: 120);
                },
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cartProduct.product.title,
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(fontSize: 24),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Cor: ${cartProduct.color}",
                      style: Theme.of(context).textTheme.display1,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "R\$ ${cartProduct.product.price.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.body2,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: cartProduct.quantity > 1
                              ? () => User.of(context)
                                  .cart
                                  .modifyCartProductQuantity(-1, cartProduct)
                              : null,
                        ),
                        Text(cartProduct.quantity.toString()),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => User.of(context)
                              .cart
                              .modifyCartProductQuantity(1, cartProduct),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                User.of(context)
                                    .cart
                                    .removeFromCart(cartProduct);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
