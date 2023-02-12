import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/user/login/myCreateAccountButton.dart';
import 'package:lojavirtualflutter/app/pages/user/login/myForgetPasswordButton.dart';
import 'package:lojavirtualflutter/app/pages/user/validators.dart';
import 'package:lojavirtualflutter/app/widgets/myOkButton.dart';
import 'package:lojavirtualflutter/app/widgets/myTextFormField.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.white,
  );
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void doLogin(User model) {
    model.logIn(
      email: emailController.text,
      password: passwordController.text,
      onSucess: sucess,
      onFail: fail,
    );
  }

  void sucess() async {
    Navigator.of(context).pop();
  }

  void fail(PlatformException error) {
    String message;
    if (error.code == "ERROR_INVALID_EMAIL")
      message = "O email informado não é válido!";
    else if (error.code == "ERROR_USER_NOT_FOUND")
      message = "O email não corresponde a nenhum usuário cadastrado!";
    else if (error.code == "ERROR_WRONG_PASSWORD")
      message = "Senha incorreta!";
    else if (error.code == "ERROR_TOO_MANY_REQUESTS")
      message = "Usuário temporariamente bloqueado devido ao excesso" +
          " de tentativas de login!";
    else
      message = "Um erro ocorreu, tente novamente mais tarde!";

    showSnackBar(Color.fromARGB(220, 230, 0, 0), message, 4);
  }

  void showSnackBar(Color color, String message, int time) {
    scaffoldKey.currentState.removeCurrentSnackBar();
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

  void forgetPassword(User model) async {
    if (emailController.text.isEmpty) {
      String message = "Preencha seu email para recuperar a senha...";
      showSnackBar(Color.fromARGB(220, 230, 0, 0), message, 4);
    } else {
      await model.recoverPassword(emailController.text, forgetPassSucess, fail);
    }
  }

  void forgetPassSucess() {
    String message =
        "Acabamos de enviar um email com as instruções de recuperação da senha...";
    showSnackBar(Color.fromARGB(220, 21, 152, 21), message, 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ScopedModelDescendant<User>(builder: (context, child, model) {
        void loginValidate() {
          if (formKey.currentState.validate()) {
            doLogin(model);
          }
        }

        void validateForgetPassword() => forgetPassword(model);

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
                      text: "Email:",
                      style: style,
                      validator: Validator.emailValidator,
                      type: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    SizedBox(height: 10.0),
                    MyTextFormField(
                      text: "Senha:",
                      style: style,
                      validator: Validator.passwordValidator,
                      obscure: true,
                      controller: passwordController,
                    ),
                    MyForgetPasswordButton(style, validateForgetPassword),
                    SizedBox(height: 20.0),
                    MyOkButton("Entrar", style, loginValidate),
                    SizedBox(height: 30.0),
                    MyCreateAccountButton(style),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
