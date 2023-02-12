import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/models/product.dart';
import 'package:lojavirtualflutter/app/pages/user/login/login.dart';
import 'package:lojavirtualflutter/app/widgets/cartButton.dart';
import 'package:lojavirtualflutter/app/widgets/waitingWidget.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<ProductPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Product product;
  _ProductPageState(this.product);

  String selectedColor;

  void initColor() {
    if (selectedColor == null) {
      selectedColor = product.colors[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    initColor();
    final Color primary = Theme.of(context).primaryColor;
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: CartButton(),
      appBar: AppBar(
        title: Text(
          product.title,
          style: Theme.of(context).textTheme.subtitle,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Carousel(
                images: product.images.map((image) {
                  return NetworkImage(image);
                }).toList(),
                dotSize: 4,
                dotSpacing: 20,
                dotBgColor: Colors.transparent,
                dotColor: primary,
                autoplay: false,
                boxFit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: Text(
                    "R\$ ${product.price}",
                    style: TextStyle(fontSize: 25, color: Colors.indigoAccent),
                  ),
                ),
                Divider(color: Colors.grey[800]),
                Text(
                  "Cor do produto:",
                  style: Theme.of(context).textTheme.display1,
                ),
                SizedBox(
                  height: 50,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.3),
                    children: product.colors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: selectedColor == color
                                  ? Colors.indigoAccent
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey[200],
                              )),
                          alignment: Alignment.center,
                          child: Text(
                            color,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 15),
                ScopedModelDescendant<User>(
                  builder: (context, widget, model) {
                    if (!model.isLoading) {
                      return Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(110, 110, 110, 155),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          child: Text(
                            model.isLogged()
                                ? "Adicionar ao carinho"
                                : "Faça Login para comprar...",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.body1,
                          ),
                          onPressed: () {
                            model.isLogged()
                                ? addToCart(model)
                                : openLoginPage(context);
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 55,
                        child: WaitingWidget(height: 30, width: 30),
                      );
                    }
                  },
                ),
                SizedBox(height: 15),
                Text(
                  "Descrição:",
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 15, color: Colors.grey[400]),
                ),
                SizedBox(height: 60),
              ],
            ),
          )
        ],
      ),
    );
  }

  void addToCart(User model) {
    model.cart.addToCart(
      product: product,
      selectedColor: selectedColor,
      onSucess: sucess,
      onFail: fail,
    );
  }

  void sucess() {
    showSnackBar(Color.fromARGB(220, 21, 152, 21), "Produto Adicionado!", 2);
  }

  void fail(error) {
    String message = "Não foi possível adicionar o produto ao carrinho!";
    showSnackBar(Color.fromARGB(220, 230, 0, 0), message, 2);
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

  void openLoginPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
