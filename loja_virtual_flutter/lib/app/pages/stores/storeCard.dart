import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/models/store.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  final Store store;
  StoreCard(this.store);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: Image.network(
              store.photo,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return WaitingWidget(width: 50, height: 50);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  store.name,
                  style: Theme.of(context).textTheme.body1,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 2),
                Text(
                  store.adress,
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.location_on, size: 35),
                      onPressed: () {
                        launch(
                            "https://www.google.com/maps/search/?api=1&query=" +
                                "${store.latitude}${store.longitude}");
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.call, size: 35),
                      onPressed: () {
                        launch("tel:${store.phone}");
                      },
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
