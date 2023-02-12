import 'package:flutter/material.dart';

class OrderResum extends StatelessWidget {
  final double subtotal;
  final double discount;
  final double shipping;
  final TextStyle subtitle;
  OrderResum(this.subtotal, this.discount, this.shipping, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        resumRow(
          "SubTotal:",
          "R\$ ${subtotal.toStringAsFixed(2)}",
          subtitle,
        ),
        Divider(),
        resumRow(
          "Desconto:",
          "R\$ ${discount.toStringAsFixed(2)}",
          subtitle,
        ),
        Divider(),
        resumRow(
          "Frete:",
          "R\$ ${shipping.toStringAsFixed(2)}",
          subtitle,
        ),
        Divider(),
        SizedBox(height: 5),
        resumRow(
            "TOTAL:",
            "R\$ ${(subtotal - discount + shipping).toStringAsFixed(2)}",
            Theme.of(context).textTheme.body2),
      ],
    );
  }

  Widget resumRow(String text1, String text2, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(text1, style: style),
        Text(text2, style: style),
      ],
    );
  }
}
