import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/products/products.dart';

class CategoryButton extends StatelessWidget {
  final category;
  CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(category["icon"]),
      ),
      title: Text(category["title"]),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.white70,
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProductsList(category)));
      },
    );
  }
}
