import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora de IMC",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String resultsText = "Aguardando dados...";
  String _infoText = "";
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  void _refresh() {
    _weightController.text = "";
    _heightController.text = "";
    setState(() {
      resultsText = "Aguardando dados...";
      _infoText = "";
      _keyForm = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;
    double imc = (weight / (height * height));
    setState(() {
      resultsText = "IMC = ${imc.toStringAsPrecision(3)}";
      if (imc < 18.5) {
        _infoText = "Abaixo do peso";
      } else if (imc < 24.9) {
        _infoText = "Peso normal";
      } else if (imc < 29.9) {
        _infoText = "Sobrepeso";
      } else if (imc < 34.9) {
        _infoText = "Obesidade grau I";
      } else if (imc < 39.9) {
        _infoText = "Obesidade grau II";
      } else {
        _infoText = "Obesidade grau III";
      }
    });
  }

  // ignore: missing_return
  String _validate(String value) {
    if (value.isEmpty) {
      return "Preenchimento obrigatório";
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            "Informações",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Text(
              "     O índice de massa corporal (IMC) é uma medida"
              " usada para calcular se uma pessoa está em seu peso ideal.\n\n"
              "     Classificação:\n"
              "* Abaixo de 18,49 - Abaixo do peso\n"
              "* De 18,50 à 24,99 - Peso normal\n"
              "* De 25 à 29,99 - Acima do peso\n"
              "* De 30 à 34,99 - Obesidade I\n"
              "* De 35 à 39,99 - Obesidade II (severa)\n"
              "* Acima de 40 - Obesidade III (mórbida)",
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              height: 50,
              width: 100,
              child: RaisedButton(
                  color: Colors.white,
                  child: Text("Sair", style: TextStyle(color: Colors.deepPurple, fontSize: 20)),
                  onPressed: () => Navigator.of(context).pop()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.info_outline), onPressed: _showDialog),
            IconButton(icon: Icon(Icons.refresh), onPressed: _refresh)
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
            child: Form(
              key: _keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline,
                      color: Colors.deepPurple, size: 120),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    validator: (value) => _validate(value),
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                  ),
                  TextFormField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    validator: (value) => _validate(value),
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, top: 10),
                    child: Container(
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {
                          if (_keyForm.currentState.validate()) {
                            _calculate();
                          }
                        },
                        color: Colors.deepPurple,
                        child: Text("Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                    ),
                  ),
                  Text(
                    resultsText,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _infoText,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )));
  }
}
