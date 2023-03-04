import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../my_pages2/card_uni.dart';
import '../../values/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../providers/page1provider.dart';
import '../../providers/page1settings.dart';
import '../../values/colors.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final TextEditingController _importo;

  @override
  void initState() {
    super.initState();
    _importo = TextEditingController()
      ..addListener(() {
        setState(() {
          getTime();
        });
      });
  }

  List<products> product = [];

  Future getTime() async {
    product = [];
    var response3 = await http.get(Uri.http(
        Constants.api, '/api/v1/products', {'keyword': '${_importo.text}'}));
    var mitem = json.decode(utf8.decode(response3.bodyBytes))['data'];
    for (int i = 0; i < mitem.length; i++) {
      // ignore: curly_braces_in_flow_control_structures
      product.add(products(
          id: mitem[i]['id'],
          name_tm: mitem[i]['name_tm'],
          name_ru: mitem[i]['name_ru'],
          description_tm: mitem[i]['descrioption_tm'].toString(),
          description_ru: mitem[i]['descrioption_ru'].toString(),
          image: mitem[i]['image'],
          price: double.parse(mitem[i]['price']),
          count: mitem[i]['count'],
          rating: double.parse(mitem[i]['rating']),
          discount: mitem[i]['discount'],
          discount_price: double.parse(mitem[i]['discounted_price'] == null
              ? "0.00"
              : mitem[i]['discounted_price'].toString()),
          category: mitem[i]['category']['id'].toString(),
          values: mitem[i]['values']));
    }
    print(mitem);
    setState(() {});
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    print('leng ${product.length}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 60,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: AppColors.appBar_back,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: (() {
                    Navigator.pop(context);
                  }),
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.light_silver,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/back.svg',
                      color: Colors.black,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),
                // ignore: prefer_const_constructors
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: AppColors.light_silver,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 20, right: 5),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              textAlign: TextAlign.start,
                              controller: _importo,
                              autofocus: true,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.primary, width: 2.0),
                                ),
                                // ignore: prefer_const_constructors
                                labelStyle: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 15),
                          child: SvgPicture.asset(
                            'assets/images/search.svg',
                            color: AppColors.primary,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(100),
      ),
      body: (product.length == 0)
          ? Text('')
          : ListView.builder(
              shrinkWrap: true,
              itemCount: product.length,
              itemBuilder: (BuildContext context, int index) {
                return CardUni(
                    product[index].id,
                    product[index].name_tm,
                    product[index].name_ru,
                    product[index].description_tm,
                    product[index].description_ru,
                    product[index].image,
                    product[index].price,
                    product[index].count,
                    product[index].rating,
                    product[index].discount,
                    product[index].discount_price,
                    product[index].category,
                    product[index].values);
              }),
    );
  }
}
