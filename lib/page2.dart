import 'package:flutter/material.dart';
import 'package:injir_new/my_pages/categories.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/providers/page1provider.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Which_page>(context);
    return Scaffold(
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 55,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Text(
                  (prov != 0) ? Constants.tm_products : Constants.ru_products,
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(100),
      ),
      body: Categories(),
    );
  }
}
