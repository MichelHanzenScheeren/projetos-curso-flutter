import 'package:flutter/material.dart';

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.signal_wifi_off, size: 120),
          SizedBox(height: 15),
          Text(
            "Não foi possível conectar-se aos servidores...",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 25),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
