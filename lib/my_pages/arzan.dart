import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/my_pages/cart_items.dart';

// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

import '../provider_bloc/cart_items/cart_bloc.dart';
import '../providers/page1provider.dart';

class Arzan extends StatefulWidget {
  const Arzan({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ArzanState createState() => _ArzanState();
}

class _ArzanState extends State<Arzan> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Which_page>(context);
    return Container(
        margin: const EdgeInsets.only(right: 5, left: 5),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    (prov.dil != 0)
                        ? Constants.tm_discounts_products
                        : Constants.ru_discounts_products,
                    style: const TextStyle(
                        fontSize: 18, fontFamily: "Semi", color: Colors.black),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 320,
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Constants.discount_products.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CartItems(Constants.discount_products[index]);
                },
              ),
            ),
          ],
        ));
  }
}
