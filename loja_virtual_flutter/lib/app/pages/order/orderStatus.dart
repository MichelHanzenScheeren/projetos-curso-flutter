import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  final int status;
  final TextStyle title;
  OrderStatus(this.status, this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(23, 8, 20, 8),
          child: Text("Status", textAlign: TextAlign.left, style: title),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              circularStatus("Preparação", status, 1),
              circularStatus("Transporte", status, 2),
              circularStatus("Entrega", status, 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget circularStatus(String text, int status, int currentStatus) {
    Color color;
    Widget circle;
    if (currentStatus > status) {
      color = Colors.grey[500];
      circle = Text(
        currentStatus.toString(),
        style: title.copyWith(fontSize: 15),
      );
    } else if (currentStatus == status) {
      color = Colors.blue;
      circle = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            currentStatus.toString(),
            style: title.copyWith(fontSize: 15),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      color = Colors.green;
      circle = Icon(Icons.check);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: color,
          child: circle,
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: title.copyWith(fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
