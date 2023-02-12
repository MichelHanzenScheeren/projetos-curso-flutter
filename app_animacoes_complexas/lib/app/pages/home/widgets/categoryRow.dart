import 'package:appanimacoescomplexas/app/themes/myTheme.dart';
import 'package:flutter/material.dart';

class CategoryRow extends StatefulWidget {
  final Animation<double> animation;
  CategoryRow(this.animation);

  @override
  _CategoryRowState createState() => _CategoryRowState(animation);
}

class _CategoryRowState extends State<CategoryRow> {
  final Animation<double> animation;
  _CategoryRowState(this.animation);

  final List categories = ["TRABALHO", "ESTUDOS", "CASA"];
  int currentCategory = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Color.fromRGBO(156, 39, 176, animation.value * 0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left, size: animation.value * 24),
            onPressed: currentCategory > 0
                ? () => setState(() => currentCategory--)
                : null,
          ),
          Text(
            categories[currentCategory],
            style: myHomeCategoriesTextStyle()
                .copyWith(fontSize: animation.value * 18),
          ),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right, size: animation.value * 24),
            onPressed: currentCategory < categories.length - 1
                ? () => setState(() => currentCategory++)
                : null,
          ),
        ],
      ),
    );
  }
}
