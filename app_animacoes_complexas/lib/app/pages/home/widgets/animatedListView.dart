import 'package:appanimacoescomplexas/app/models/toDoItem.dart';
import 'package:appanimacoescomplexas/app/themes/myTheme.dart';
import 'package:flutter/material.dart';

class AnimatedListView extends StatelessWidget {
  final Animation<EdgeInsets> animation;
  AnimatedListView({@required this.animation});

  @override
  Widget build(BuildContext context) {
    List<ToDoItem> itens = [
      ToDoItem(
        title: "Estudar Flutter",
        subtitle: "Mínimo de 2 horas por dia",
        margin: animation.value * 0,
      ),
      ToDoItem(
        title: "Estudar Inglês",
        subtitle: "Mínimo de 1 hora por dia",
        margin: animation.value * 1,
      ),
      ToDoItem(
        title: "Estudar Python",
        subtitle: "Mínimo de 30 minutos por dia",
        margin: animation.value * 2,
      )
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: itens.map((item) {
          return Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            margin: item.margin,
            decoration: BoxDecoration(
              color: Color.fromRGBO(76, 43, 136, 1),
              border: Border(
                top: BorderSide(color: Colors.purple),
                bottom: BorderSide(color: Colors.purple),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple,
                      image: DecorationImage(
                        image: AssetImage("images/home_user.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.title, style: myListTitleTextStyle()),
                      Text(item.subtitle, style: myListSubtitleTextStyle()),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
