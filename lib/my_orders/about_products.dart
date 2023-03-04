import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/my_orders/card/card_product_orders.dart';

import '../providers/page1provider.dart';
import '../providers/page1settings.dart';
import '../values/colors.dart';
import '../values/models.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

class AboutProducts extends StatefulWidget {
  var towarlar;
  AboutProducts(this.towarlar);

  @override
  _AboutProductsState createState() => _AboutProductsState();
}

class _AboutProductsState extends State<AboutProducts> {
  List<order_items> product = [];

  @override
  Widget build(BuildContext context) {
    print('halalallalalaksdfhakjsdfkaslhdfkjasdf');
    print(widget.towarlar);

    var prov = Provider.of<Which_page>(context);
    for (int i = 0; i < widget.towarlar.length; i++) {
      product.add(order_items(
          name_tm: widget.towarlar[i]['name_tm'],
          name_ru: widget.towarlar[i]['name_ru'],
          image: widget.towarlar[i]['image'],
          price: widget.towarlar[i]['price'].toString(),
          count: widget.towarlar[i]['amount'].toString()));
    }

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
      body: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: product.length,
          itemBuilder: (BuildContext context, int index) {
            return CardProductOrders(product, index);
          }),
    );
  }
}
