import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injir_new/provider_bloc/cart_items/cart_bloc.dart';
import 'package:injir_new/providers/bottom_prov.dart';
import 'package:injir_new/providers/provider_items.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/DB/db.dart';
import 'package:injir_new/main.dart';
import 'package:injir_new/providers/favourite.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/colors.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injir_new/values/models.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    getTime();
  }

  Future getTime() async {
    final data = await DatabaseHelper.getUser();
    List<Map<String, dynamic>> myData = [];
    myData = data;
    if (myData.length > 0) {
      Constants.phone = myData[0]['username'];
      Constants.token = myData[0]['token'];
      Constants.name = myData[0]['name'] + ' ' + myData[0]['surname'];
      Constants.name1 = myData[0]['name'];
      Constants.name2 = myData[0]['surname'];
      Constants.email = myData[0]['email'];
      Provider.of<BottomProv>(context, listen: false).set_reg(true);
    }
    //homePage
    try {
      var response_home = await http
          .get(Uri.http(Constants.api, '/api/v1/categories/selected'));
      var mcat_home = json.decode(utf8.decode(response_home.bodyBytes))['data'];
      for (int i = 0; i < mcat_home.length; i++) {
        Constants.categoryhome.add(categorys(
            id: mcat_home[i]['id'],
            name_tm: mcat_home[i]['name_tm'],
            name_ru: mcat_home[i]['name_ru'],
            image: 'sss',
            children: mcat_home[i]['children']));
      }
    } catch (e) {
      print('never reached');
    }
    //
    print('rec');
    try {
      var response_loc =
          await http.get(Uri.http(Constants.api, '/api/v1/locations'));
      var mloc = json.decode(utf8.decode(response_loc.bodyBytes))['data'];
      Provider.of<Which_page>(context, listen: false)
          .setDosMin(double.parse(mloc[0]['min_order_fee']));
      Provider.of<Which_page>(context, listen: false)
          .setDosPrice(double.parse(mloc[0]['shipping_fee']));
      print(Provider.of<Which_page>(context, listen: false).dostawka_min);
      print(Provider.of<Which_page>(context, listen: false).dostawka_price);
    } catch (e) {
      print('never reached');
    }

    for (int i = 0; i < Constants.categoryhome.length; i++) {
      var response3 = await http.get(Uri.http(
          Constants.api,
          '/api/v1/products/',
          {'limit': '10', 'category': '${Constants.categoryhome[i].id}'}));
      var mjack = json.decode(utf8.decode(response3.bodyBytes))['data'];
      Constants.home_data[Constants.categoryhome[i].id.toString()] = mjack;
    }
    //category
    try {
      var response =
          await http.get(Uri.http(Constants.api, '/api/v1/categories'));
      var mcat = json.decode(utf8.decode(response.bodyBytes))['data'];
      for (int i = 0; i < mcat.length; i++) {
        Constants.category.add(categorys(
            id: mcat[i]['id'],
            name_tm: mcat[i]['name_tm'],
            name_ru: (mcat[i]['name_ru'] != null) ? mcat[i]['name_ru'] : '',
            image: mcat[i]['image'],
            children: mcat[i]['children']));
      }
    } catch (e) {
      print('never reached');
    }

    //banner
    var response2 = await http.get(Uri.http(Constants.api, '/api/v1/sliders/'));
    var mban = json.decode(utf8.decode(response2.bodyBytes))['data'];
    for (int i = 0; i < mban.length; i++) {
      Constants.banner.add(sliders(id: mban[i]['id'], image: mban[i]['image']));
    }

    ///discounts
    try {
      var response_dis =
          await http.get(Uri.http(Constants.api, '/api/v1/products/discounts'));
      var mdis = json.decode(utf8.decode(response_dis.bodyBytes))['data'];
      print('object--$mdis');
      for (int i = 0; i < mdis.length; i++) {
        Constants.discount_products.add(
          Products(
              id: mdis[i]['id'],
              name_tm: (mdis[i]['name_tm'] != null) ? mdis[i]['name_tm'] : '',
              name_ru: (mdis[i]['name_ru'] != null) ? mdis[i]['name_ru'] : '',
              description_tm: (mdis[i]['descrioption_tm'] != null)
                  ? mdis[i]['descrioption_tm']
                  : "",
              description_ru: (mdis[i]['descrioption_ru'] != null)
                  ? mdis[i]['descrioption_ru']
                  : "",
              image: mdis[i]['image'],
              price: double.parse(mdis[i]['price']),
              count: 0,
              rating: double.parse(mdis[i]['rating']),
              discount: mdis[i]['discount'],
              discount_price: (mdis[i]['discounted_price'] != null)
                  ? double.parse(mdis[i]['discounted_price'].toString())
                  : 0.00,
              category: mdis[i]['category']['id'].toString(),
              values: mdis[i]['values']),
        );
      }
    } catch (e) {}
    //get and set provider items_karzina
    final datum = await DatabaseHelper.getItems();
    List<Map<String, dynamic>> myDatum = [];
    myDatum = datum;
    List<Products> products = [];
    for (int i = 0; i < myDatum.length; i++) {
      products.add(Products(
          id: myDatum[i]['productId'],
          name_tm: myDatum[i]['name_tm'],
          name_ru: myDatum[i]['name_ru'],
          description_tm: myDatum[i]['description_tm'],
          description_ru: myDatum[i]['description_ru'],
          image: myDatum[i]['image'],
          price: myDatum[i]['price'],
          count: myDatum[i]['count'],
          rating: myDatum[i]['rating'],
          discount: myDatum[i]['discount'],
          discount_price: myDatum[i]['discount_price'],
          category: myDatum[i]['category'],
          values: myDatum[i]['values']));
    }
    BlocProvider.of<CartBloc>(context).add(CartAddProductsEvent(products));

    //read and set provider favourites
    final fav = await DatabaseHelper.getFavor();
    List<Map<String, dynamic>> myFav = [];
    myFav = fav;
    for (int i = 0; i < myFav.length; i++) {
      Provider.of<Favourite>(context, listen: false).addSplash(
          myFav[i]['productId'],
          myFav[i]['name_tm'],
          myFav[i]['name_ru'],
          myFav[i]['description_tm'],
          myFav[i]['description_ru'],
          myFav[i]['image'],
          myFav[i]['price'],
          myFav[i]['count'],
          myFav[i]['rating'],
          myFav[i]['discount'],
          myFav[i]['discount_price'],
          myFav[i]['category'],
          myFav[i]['values']);
    }
    final diller = await DatabaseHelper.getDiller();
    List<Map<String, dynamic>> lan = diller;
    if (lan.length > 0) {
      if (lan[0]['dil'] == 0)
        Provider.of<Which_page>(context, listen: false).setRu();
      else
        Provider.of<Which_page>(context, listen: false).setTm();
    } else {
      DatabaseHelper.createDill(1, 1);
    }

    Constants.dil = true;
    /*
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(
              context,
              '/home',
            );*/
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/idris_logo.png',
              width: 170,
              height: 170,
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 50,
            ),
            const CircularProgressIndicator(
              strokeWidth: 4.0,
              color: AppColors.primary,
              semanticsLabel: 'Circular progress indicator',
            ),
          ],
        ),
      ),
    );
  }
}
