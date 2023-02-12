import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';

class DiscountCard extends StatelessWidget {
  final iconColor = Color.fromARGB(245, 225, 225, 225);
  final textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: Colors.grey[600]),
  );
  final Function(String cupom) submitDiscount;
  DiscountCard(this.submitDiscount);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: Icon(Icons.card_giftcard, color: iconColor),
        title: Text(
          "Cupom de Desconto",
          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 22),
          textAlign: TextAlign.start,
        ),
        trailing: Icon(Icons.add, color: iconColor),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
            child: TextFormField(
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: User.of(context).cart.coupon == null
                    ? "Digite seu cupom:"
                    : null,
                border: textFieldBorder,
                enabledBorder: textFieldBorder,
              ),
              initialValue: User.of(context).cart.coupon == null
                  ? null
                  : User.of(context).cart.coupon["title"],
              onFieldSubmitted: submitDiscount,
            ),
          ),
        ],
      ),
    );
  }
}
