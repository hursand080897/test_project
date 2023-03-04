import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/page1provider.dart';

class Harytlar extends StatefulWidget {
  int id;
  String name_tm;
  String name_ru;
  var children;
  Harytlar(this.id, this.name_tm, this.name_ru, this.children);

  @override
  _HarytlarState createState() => _HarytlarState();
}

class _HarytlarState extends State<Harytlar> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Which_page>(context);
    print('children${widget.children}');
    return Container(
        height: 30,
        margin: const EdgeInsets.only(left: 15),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                (prov.dil != 0) ? widget.name_tm : widget.name_ru,
                style: const TextStyle(
                    fontSize: 18, fontFamily: "Semi", color: Colors.black),
              ),
            ),
          ],
        ));
  }
}
