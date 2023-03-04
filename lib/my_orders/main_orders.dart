import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/my_orders/activ.dart';
import 'package:injir_new/my_orders/disactiv.dart';
import 'package:injir_new/values/colors.dart';

import '../providers/page1provider.dart';
import '../providers/page1settings.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

class MainOrders extends StatefulWidget {
  const MainOrders({Key? key}) : super(key: key);

  @override
  _MainOrdersState createState() => _MainOrdersState();
}

class _MainOrdersState extends State<MainOrders> {
  bool aktiw = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<PageSettings>(context).page == 1) {
      Navigator.pop(context);
    }
    var prov = Provider.of<Which_page>(context);
    return Scaffold(
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 60,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: AppColors.appBar_back),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    (Provider.of<Which_page>(context).dil != 0)
                        ? Constants.tm_orders
                        : Constants.ru_orders,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          color: Color.fromARGB(0, 255, 255, 255),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        aktiw = true;
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // ignore: unrelated_type_equality_checks
                        color: (aktiw == true)
                            ? AppColors.primary
                            : AppColors.light_silver,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        (Provider.of<Which_page>(context).dil != 0)
                            ? 'Aktiw'
                            : 'Активные',
                        style: TextStyle(
                            color:
                                (aktiw == true) ? Colors.white : Colors.black,
                            fontFamily: 'Semi'),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        aktiw = false;
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // ignore: unrelated_type_equality_checks
                        color: (aktiw == false)
                            ? AppColors.primary
                            : AppColors.light_silver,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        (Provider.of<Which_page>(context).dil != 0)
                            ? 'Öňki sargytlar'
                            : 'Прошлые заказы',
                        style: TextStyle(
                            color:
                                (aktiw == false) ? Colors.white : Colors.black,
                            fontFamily: 'Semi'),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              (aktiw == true) ? Activ() : Disactiv(),
            ],
          ),
        ),
      ),
    );
  }
}
