import 'package:flutter/material.dart';

class ShippingCard extends StatelessWidget {
  final iconColor = Color.fromARGB(245, 225, 225, 225);
  final textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: Colors.grey[600]),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: Icon(Icons.location_on, color: iconColor),
        title: Text(
          "Cálculo do frete",
          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 22),
          textAlign: TextAlign.start,
        ),
        trailing: Icon(Icons.arrow_drop_down, color: iconColor),
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
                hintText: "CEP:",
                border: textFieldBorder,
                enabledBorder: textFieldBorder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
