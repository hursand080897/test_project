import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/values/colors.dart';

import '../my_pages/banner.dart';
import '../my_pages/bash sahypa/search.dart';
import '../provider_bloc/cart_items/cart_bloc.dart';
import '../providers/page1provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;
import 'package:injir_new/my_pages/cart_items.dart';

class SubCat extends StatefulWidget {
  @override
  _SubCatState createState() => _SubCatState();
}

class _SubCatState extends State<SubCat> {
  List<Products> product = [];
  bool loading = true;
  int pindex = -2;
  String sort_by = 'cheap';
  Future getTime() async {
    product = [];
    pindex = -2;
    print('bingo');
    try {
      var response3 = await http.get(Uri.http(
          Constants.api,
          '/api/v1/products/',
          {'category': '${Constants.myCatID}', 'sort_by': sort_by}));
      var mitem = json.decode(utf8.decode(response3.bodyBytes))['data'];
      for (int i = 0; i < mitem.length; i++) {
        // ignore: curly_braces_in_flow_control_structures
        product.add(Products(
            id: mitem[i]['id'],
            name_tm: (mitem[i]['name_tm'] != null) ? mitem[i]['name_tm'] : ' ',
            name_ru: (mitem[i]['name_ru'] != null) ? mitem[i]['name_ru'] : ' ',
            description_tm: (mitem[i]['descrioption_tm'] != null)
                ? mitem[i]['descrioption_tm']
                : ' ',
            description_ru: (mitem[i]['descrioption_ru'] != null)
                ? mitem[i]['descrioption_ru']
                : ' ',
            image: mitem[i]['image'],
            price: double.parse(mitem[i]['price']),
            count: 0,
            rating: double.parse(mitem[i]['rating']),
            discount: mitem[i]['discount'],
            discount_price: double.parse(mitem[i]['discounted_price'] == null
                ? "0.00"
                : mitem[i]['discounted_price']),
            category: mitem[i]['category']['id'].toString(),
            values: mitem[i]['values']));
      }
    } catch (e) {}
    setState(() {
      loading = false;
    });
  }

  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    var prov_dil = Provider.of<Which_page>(context).dil;

    return Scaffold(
      backgroundColor: AppColors.appBar_back,
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 60,
            margin: const EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: const BoxDecoration(color: AppColors.appBar_back),
            child: Stack(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: AppColors.light_silver,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(
                            'assets/images/search.svg',
                            color: AppColors.primary,
                            allowDrawingOutsideViewBox: true,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            (Provider.of<Which_page>(context).dil != 0)
                                ? 'Gözleg...'
                                : 'Поиск...',
                            style: const TextStyle(
                                color: AppColors.silver, fontFamily: 'Semi'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(100),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 15, top: 5, left: 5, right: 5),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  margin: const EdgeInsets.only(left: 10, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        Constants.prevCatName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Semi',
                        ),
                      ),
                    ],
                  )),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 10, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.myCatName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Semi',
                        ),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: const BannerScreen()),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          prov_dil != 0 ? 'Meşhur' : 'Популярные',
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.primary),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        SvgPicture.asset(
                          'assets/images/popular_item.svg',
                          color: AppColors.primary,
                          allowDrawingOutsideViewBox: true,
                        ),
                        Expanded(child: Container()),
                        Text(
                          prov_dil != 0 ? 'Filter' : 'Филтьр',
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.primary),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          'assets/images/filter.svg',
                          color: AppColors.primary,
                          height: 12,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  (loading == false)
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 320,
                          ),
                          itemCount: product.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CartItems(product[index]);
                          },
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            strokeWidth: 4.0,
                            color: AppColors.primary,
                            semanticsLabel: 'Circular progress indicator',
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              width: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            fontFamily: 'Semi',
                            color: AppColors.primary,
                            fontSize: 16),
                      ),
                      child: Text(
                        (Provider.of<Which_page>(context).dil != 0)
                            ? 'FILTER'
                            : 'ФИЛЬТР',
                        style: TextStyle(
                            fontFamily: 'Semi',
                            color: AppColors.primary,
                            fontSize: 16),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                        ),
                        TextButton(
                          child: Text(
                            (Provider.of<Which_page>(context).dil != 0)
                                ? 'ARZANDAN GYMMADA'
                                : 'СНАЧАЛА ДЕШЕВЫЕ',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              loading = true;
                              sort_by = 'cheap';
                            });
                            getTime();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                        ),
                        TextButton(
                          child: Text(
                            (Provider.of<Which_page>(context).dil != 0)
                                ? 'GYMMATDAN ARZANA'
                                : 'СНАЧАЛА ДОРОГИЕ',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              sort_by = 'expensive';
                              loading = true;
                            });
                            getTime();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                        ),
                        TextButton(
                          child: Text(
                            (Provider.of<Which_page>(context).dil != 0)
                                ? 'KÖNEDEN TÄZE'
                                : 'СНАЧАЛА СТАРЫЕ',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              sort_by = 'oldest';
                              loading = true;
                            });
                            getTime();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                        ),
                        TextButton(
                          child: Text(
                            (Provider.of<Which_page>(context).dil != 0)
                                ? 'TÄZEDEN KÖNÄ'
                                : 'СНАЧАЛА НОВИНКИ',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              sort_by = 'latest';
                              loading = true;
                            });
                            getTime();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
