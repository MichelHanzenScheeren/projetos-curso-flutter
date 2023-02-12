import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/database.dart';
import 'package:lojavirtualflutter/app/models/cartProduct.dart';
import 'package:lojavirtualflutter/app/models/order.dart';
import 'package:lojavirtualflutter/app/models/orderProduct.dart';
import 'package:lojavirtualflutter/app/models/product.dart';

class CartController {
  List<CartProduct> cartProducts;
  Map<String, dynamic> coupon;
  FirebaseUser currentUser;
  Function notifyListeners;
  Function setLoading;

  CartController(this.currentUser, this.notifyListeners, this.setLoading);

  Future getCartProducts(String userUid) async {
    cartProducts = await Database.instance.getCartProducts(userUid);
  }

  int productsCount() {
    if (cartProducts == null) {
      return 0;
    } else {
      return cartProducts.fold(0, (sum, item) {
        return item.quantity + sum;
      });
    }
  }

  void addToCart({
    @required Product product,
    @required String selectedColor,
    @required Function onSucess,
    @required Function onFail,
  }) async {
    setLoading(true);
    CartProduct item = findCartProduct(product.id, selectedColor);
    if (item == null) {
      CartProduct cartProduct = CartProduct(
        productUid: product.id,
        categoryUid: product.category,
        quantity: 1,
        color: selectedColor,
      );

      Database.instance.newCartItem(currentUser.uid, cartProduct).then((uid) {
        cartProduct.cartUid = uid;
        if (cartProducts == null) {
          cartProducts = List<CartProduct>();
        }
        cartProducts.add(cartProduct);
        sucess(onSucess);
      }).catchError((error) {
        fail(onFail, error);
      });
    } else {
      item.quantity += 1;
      Database.instance.updateCartItemQuantity(currentUser.uid, item).then((_) {
        sucess(onSucess);
      }).catchError((error) {
        fail(onFail, error);
      });
    }
  }

  CartProduct findCartProduct(String productId, String color) {
    return cartProducts?.firstWhere((item) {
      return item.productUid == productId && item.color == color;
    }, orElse: () => null);
  }

  void sucess(Function onSucess) {
    onSucess();
    setLoading(false);
  }

  void fail(Function onFail, dynamic error) {
    onFail(error);
    setLoading(false);
  }

  void removeFromCart(CartProduct cartProduct) {
    Database.instance.removeFromCart(currentUser.uid, cartProduct.cartUid);
    cartProducts.remove(cartProduct);
    notifyListeners();
  }

  Future getProductById(CartProduct cartProduct) async {
    cartProduct.product = await Database.instance
        .getProductById(cartProduct.categoryUid, cartProduct.productUid);
    notifyListeners();
  }

  void modifyCartProductQuantity(int num, CartProduct cartProduct) {
    cartProduct.quantity += num;
    Database.instance.updateCartItemQuantity(currentUser.uid, cartProduct);
    notifyListeners();
  }

  Future<bool> submitCoupom(String text) async {
    coupon = await Database.instance.getCoupom(text);
    notifyListeners();
    return coupon != null;
  }

  double getSubtotalOfCart() {
    double subTotal = 0;
    for (CartProduct cartProduct in cartProducts) {
      if (cartProduct.product != null)
        subTotal += (cartProduct.quantity * cartProduct.product.price);
    }
    return subTotal;
  }

  double getDiscountOfCart() {
    if (coupon != null) {
      return getSubtotalOfCart() * coupon["percent"] / 100;
    } else
      return 0;
  }

  double getShippingOfCart() {
    return 0;
  }

  Future finishOrder({
    @required Function onSucess,
    @required Function onFail,
  }) async {
    if (cartProducts == null || cartProducts.length == 0) onFail();

    setLoading(true);
    Order order = createOrder(
      getSubtotalOfCart(),
      getDiscountOfCart(),
      getShippingOfCart(),
    );

    await Database.instance.saveOrder(order).then((orderUid) {
      Database.instance.clearCart(currentUser.uid);
      if (cartProducts != null) cartProducts.clear();
      if (coupon != null) coupon = null;
      onSucess(orderUid);
      setLoading(false);
    }).catchError((error) {
      onFail();
      setLoading(false);
    });
  }

  Order createOrder(double subTotal, double discount, double shipping) {
    return Order(
      userUid: currentUser.uid,
      subtotal: subTotal,
      discount: discount,
      shipping: shipping,
      orderProducts: cartProducts.map((doc) {
        return OrderProduct.fromCartProduct(doc);
      }).toList(),
      status: 1,
    );
  }
}
