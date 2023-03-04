import 'package:flutter/material.dart';

import 'package:injir_new/my_pages/cart_items.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;
import 'package:injir_new/values/models.dart';

import '../../provider_bloc/cart_items/cart_bloc.dart';

class HomeItemPage extends StatefulWidget {
  int id;
  HomeItemPage(this.id);

  @override
  _HomeItemPageState createState() => _HomeItemPageState();
}

class _HomeItemPageState extends State<HomeItemPage> {
  List<Products> product = [];

  Future getTime() async {
    var m = Constants.home_data[widget.id.toString()];
    for (int i = 0; i < m.length; i++) {
      product.add(Products(
          id: m[i]['id'],
          name_tm: (m[i]['name_tm'] != null) ? m[i]['name_tm'] : '',
          name_ru: (m[i]['name_ru'] != null) ? m[i]['name_ru'] : '',
          description_tm:
              (m[i]['descrioption_tm'] != null) ? m[i]['descrioption_tm'] : '',
          description_ru:
              (m[i]['descrioption_ru'] != null) ? m[i]['descrioption_ru'] : '',
          image: m[i]['image'],
          price: double.parse(m[i]['price']),
          count: m[i]['count'],
          rating: double.parse(m[i]['rating']),
          discount: m[i]['discount'],
          discount_price: (m[i]['discounted_price'] != null)
              ? double.parse(m[i]['discounted_price'].toString())
              : 0.00,
          category: m[i]['category']['id'].toString(),
          values: m[i]['values']));
    }

    setState(() {});
    return 0;
  }

  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return CartItems(product[index]);
        },
      ),
    );
  }
}
