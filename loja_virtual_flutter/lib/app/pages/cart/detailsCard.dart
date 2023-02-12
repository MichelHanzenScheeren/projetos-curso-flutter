import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailsCard extends StatelessWidget {
  final Function finishOrder;
  DetailsCard(this.finishOrder);

  @override
  Widget build(BuildContext context) {
    TextStyle body1 = Theme.of(context).textTheme.body1.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        );
    TextStyle display1 = Theme.of(context).textTheme.display1.copyWith(
          fontSize: 20,
        );
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: ScopedModelDescendant<User>(
          builder: (context, widget, model) {
            double subTotal = model.cart.getSubtotalOfCart();
            double discount = model.cart.getDiscountOfCart();
            double shipping = model.cart.getShippingOfCart();

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do Pedido:",
                  style: body1,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("SubTotal:", style: display1),
                    Text(
                      "R\$ ${subTotal.toStringAsFixed(2)}",
                      style: display1,
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Desconto:", style: display1),
                    Text("R\$ ${discount.toStringAsFixed(2)}", style: display1),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Frete:", style: display1),
                    Text("R\$ ${shipping.toStringAsFixed(2)}", style: display1),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("TOTAL:", style: body1),
                    Text(
                        "R\$ ${(subTotal - discount + shipping).toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.body2),
                  ],
                ),
                SizedBox(height: 25),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(110, 110, 110, 155),
                  child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text(
                      "Finalizar Pedido",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    onPressed: finishOrder,
                  ),
                ),
                SizedBox(height: 12),
              ],
            );
          },
        ),
      ),
    );
  }
}
