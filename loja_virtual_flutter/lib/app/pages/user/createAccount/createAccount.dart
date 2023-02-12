import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/models/client.dart';
import 'package:lojavirtualflutter/app/pages/user/createAccount/myUserTerms.dart';
import 'package:lojavirtualflutter/app/pages/user/validators.dart';
import 'package:lojavirtualflutter/app/widgets/myOkButton.dart';
import 'package:lojavirtualflutter/app/widgets/myTextFormField.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.white,
  );
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  String confirmPasswordValidator(String text) {
    return Validator.confirmPasswordValidator(text, passwordController);
  }

  void doCreateAccount(User model) {
    Client client = Client(
      emailController.text.trim(),
      nameController.text.trim(),
      lastNameController.text.trim(),
    );
    model.createAccount(
      data: client,
      password: passwordController.text,
      onSucess: sucess,
      onFail: fail,
    );
  }

  Future sucess() async {
    String message = "Usuário criado com sucesso!";
    showSnackBar(Color.fromARGB(220, 21, 152, 21), message, 2);
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }

  void fail(PlatformException error) {
    String message;
    if (error.code == "ERROR_INVALID_EMAIL")
      message = "O email informado não é válido!";
    else if (error.code == "ERROR_EMAIL_ALREADY_IN_USE")
      message = "Este email já possui uma conta vinculada!";
    else
      message = "Não foi possível concluir o cadastro..." +
          "\nTente novamente mais tarde!";

    showSnackBar(Color.fromARGB(220, 230, 0, 0), message, 3);
  }

  void showSnackBar(Color color, String message, int time) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.display1.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        backgroundColor: color,
        duration: Duration(seconds: time),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ScopedModelDescendant<User>(
        builder: (context, child, model) {
          void allValidate() {
            if (formKey.currentState.validate()) doCreateAccount(model);
          }

          if (model.isLoading) return WaitingWidget(width: 50, height: 50);

          return Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      MyTextFormField(
                        text: "Nome:",
                        style: style,
                        validator: Validator.basicValidator,
                        controller: nameController,
                      ),
                      SizedBox(height: 15.0),
                      MyTextFormField(
                        text: "Sobrenome:",
                        style: style,
                        validator: Validator.basicValidator,
                        controller: lastNameController,
                      ),
                      SizedBox(height: 15.0),
                      MyTextFormField(
                        text: "Email:",
                        style: style,
                        validator: Validator.emailValidator,
                        type: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      SizedBox(height: 15.0),
                      MyTextFormField(
                        text: "Senha:",
                        style: style,
                        validator: Validator.passwordValidator,
                        obscure: true,
                        controller: passwordController,
                      ),
                      SizedBox(height: 15.0),
                      MyTextFormField(
                        text: "Confirme sua senha:",
                        style: style,
                        validator: confirmPasswordValidator,
                        obscure: true,
                      ),
                      SizedBox(height: 20.0),
                      MyUserTerms(style),
                      SizedBox(height: 20.0),
                      MyOkButton("Criar conta", style, allValidate),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
