import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/photo_view.dart';
import 'package:injir_new/providers/provider_items.dart';
import 'package:injir_new/values/models.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/providers/favourite.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/colors.dart';
import 'package:injir_new/values/constants.dart' as Constants;
import 'dart:convert';
import 'package:http/http.dart' as http;

class OptionsItem extends StatefulWidget {
  const OptionsItem({Key? key}) : super(key: key);
  @override
  _OptionsItemState createState() => _OptionsItemState();
}

class _OptionsItemState extends State<OptionsItem> {
  bool descrip = false;
  bool vis_size = true;
  bool vis_color = true;
  List<ColorPick> colors = [];
  List<String> sizes = [];
  String text_size = '';
  bool loading = true;
  List<products> product = [];

  Future getTime() async {
    product.add(products(
        id: Constants.op_id,
        name_tm: Constants.op_name_tm,
        name_ru: Constants.op_name_ru,
        description_tm: Constants.op_description_tm,
        description_ru: Constants.op_description_ru,
        image: Constants.op_image,
        price: Constants.op_price,
        count: Constants.op_count,
        rating: Constants.op_rating,
        discount: Constants.op_discount,
        discount_price: Constants.op_discount_price,
        category: Constants.op_category,
        values: Constants.op_values));
    loading = false;
    var response3 = await http
        .get(Uri.http(Constants.api, '/api/v1/sets/${Constants.op_id}'));

    var mitem =
        json.decode(utf8.decode(response3.bodyBytes))['data']['products'];

    for (int i = 0; i < mitem.length; i++) {
      product.add(products(
          id: mitem[i]['id'],
          name_tm: mitem[i]['name_tm'],
          name_ru: mitem[i]['name_ru'],
          description_tm: (mitem[i]['descrioption_tm'] != null)
              ? mitem[i]['descrioption_tm']
              : "",
          description_ru: (mitem[i]['descrioption_ru'] != null)
              ? mitem[i]['descrioption_ru']
              : "",
          image: mitem[i]['image'],
          price: double.parse(mitem[i]['price']),
          count: 0,
          rating: double.parse(mitem[i]['rating']),
          discount: mitem[i]['discount'],
          discount_price: double.parse(
              (mitem[i]['discounted_price'].toString() != null)
                  ? mitem[i]['discounted_price'].toString()
                  : "0.00"),
          category: mitem[i]['category']['id'].toString(),
          values: mitem[i]['values']));
    }
    sizes = [];
    colors = [];

    try {
      for (int i = 0; i < Constants.op_values.length; i++) {
        if (Constants.op_values[i]['option']['is_color'] == "0") {
          colors.add(ColorPick(
              id: Constants.op_id, colors: Constants.op_values[i]['color']));
        }
      }
    } catch (e) {
      print(e);
    }

    try {
      for (int j = 0; j < product.length; j++) {
        for (int i = 0; i < product[j].values.length; i++) {
          if (product[j].values[i]['option']['is_color'] != "0") {
            print(product[j].id);
            colors.add(ColorPick(
                id: product[j].id, colors: product[j].values[i]['color']));
          }
        }
      }
    } catch (e) {
      print(e);
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
    var prov = Provider.of<Which_page>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 60,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: AppColors.appBar_back),
            child: Stack(
              children: [
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
                            size: 15,
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
        color: Colors.white,
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    (prov.dil != 0)
                        ? Constants.op_name_tm
                        : Constants.op_name_ru,
                    maxLines: 3,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                        color: Colors.black, fontSize: 16, fontFamily: 'Semi'),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: (() {
                    if (Provider.of<Favourite>(context, listen: false)
                            .items[Constants.op_id]
                            ?.count ==
                        null) {
                      Provider.of<Favourite>(context, listen: false).addItem(
                          Constants.op_id,
                          Constants.op_name_tm,
                          Constants.op_name_ru,
                          Constants.op_description_tm,
                          Constants.op_description_ru,
                          Constants.op_image,
                          Constants.op_price,
                          Constants.op_count,
                          Constants.op_rating,
                          Constants.op_discount,
                          Constants.op_discount_price,
                          Constants.op_category,
                          Constants.op_values);
                    } else {
                      Provider.of<Favourite>(context, listen: false)
                          .removeItem(Constants.op_id);
                    }
                  }),
                  child: (Provider.of<Favourite>(context)
                              .items[Constants.op_id]
                              ?.count ==
                          null)
                      ? const Icon(
                          Icons.favorite_border,
                          color: Color.fromARGB(255, 218, 44, 32),
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Color.fromARGB(255, 218, 44, 32),
                        ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhotView()));
              },
              child: Container(
                alignment: Alignment.center,
                height: 390,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    Constants.op_image,
                    height: 390,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              color: Color.fromARGB(0, 255, 255, 255),
              child: Text(
                (prov.dil != 0) ? Constants.tm_full_dep : Constants.ru_full_dep,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: "Semi",
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 2,
              color: AppColors.light_silver,
            ),
            Html(
              data:
                  """${(prov.dil != 0) ? Constants.op_description_tm : Constants.op_description_ru}""",
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                height: 50,
                child: (Provider.of<ProvItem>(context)
                            .items[Constants.op_id]
                            ?.count ==
                        null)
                    ? GestureDetector(
                        onTap: () {
                          Provider.of<ProvItem>(context, listen: false).addItem(
                              Constants.op_id,
                              Constants.op_name_tm,
                              Constants.op_name_ru,
                              Constants.op_description_tm,
                              Constants.op_description_ru,
                              Constants.op_image,
                              Constants.op_price,
                              1,
                              Constants.op_rating,
                              Constants.op_discount,
                              Constants.op_discount_price,
                              Constants.op_category,
                              Constants.op_values);
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            (Provider.of<Which_page>(context).dil != 0)
                                ? 'Sebede goş'
                                : 'Добавить в корзину',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Semi'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromRGBO(248, 248, 248, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      Provider.of<ProvItem>(context,
                                              listen: false)
                                          .removeItem(Constants.op_id, 5);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        'assets/images/minus.svg',
                                        color: AppColors.primary,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    )),
                              ),
                              Expanded(
                                child: Text(
                                  (Provider.of<ProvItem>(context)
                                              .items[Constants.op_id]
                                              ?.count ==
                                          null)
                                      ? '0'
                                      : Provider.of<ProvItem>(context)
                                          .items[Constants.op_id]!
                                          .count
                                          .toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Semi'),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      Provider.of<ProvItem>(context,
                                              listen: false)
                                          .addItem(
                                              Constants.op_id,
                                              Constants.op_name_tm,
                                              Constants.op_name_ru,
                                              Constants.op_description_tm,
                                              Constants.op_description_ru,
                                              Constants.op_image,
                                              Constants.op_price,
                                              1,
                                              Constants.op_rating,
                                              Constants.op_discount,
                                              Constants.op_discount_price,
                                              Constants.op_category,
                                              Constants.op_values);
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        'assets/images/plus.svg',
                                        color: AppColors.primary,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}

/*
price
Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 10),
                      child: (Constants.op_discount != 0)
                          ? Row(
                              children: [
                                Text(
                                  '${Constants.op_discount_price} TMT ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: 'Semi',
                                  ),
                                ),
                                Text(
                                  '${Constants.op_price} TMT ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.light_black,
                                      fontFamily: 'Semi',
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            )
                          : Text(
                              '${Constants.op_price} TMT ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: 'Semi'),
                            ),
                    ),


*/