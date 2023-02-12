import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';

class SucessOrder extends StatelessWidget {
  final String orderUid;
  SucessOrder(this.orderUid);

  void countTime(BuildContext context) async {
    Future.delayed(Duration(seconds: 4)).then((_) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    countTime(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.done,
              size: 120,
              color: Color.fromARGB(220, 21, 152, 21),
            ),
            SizedBox(height: 20),
            Text(
              "Pedido finalizado, ${User.of(context)?.userData?.name ?? "obrigado"}!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 5),
            Text(
              "Código: $orderUid",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
            ),
            SizedBox(height: 70),
            WaitingWidget(height: 40, width: 40),
            SizedBox(height: 15),
            Text(
              "Aguarde...",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontSize: 15,
                    color: Colors.grey[400],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
