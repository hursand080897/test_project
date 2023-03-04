import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/page4.dart';
import 'package:injir_new/providers/bottom_prov.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/my_pages/arzan.dart';
import 'package:injir_new/my_pages/banner.dart';
import 'package:injir_new/my_pages/bash%20sahypa/search.dart';
import 'package:injir_new/my_pages/harytlar.dart';
import 'package:injir_new/my_pages/main_cat.dart';
import 'package:injir_new/my_pages/my_cat_items/home_item_page.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/colors.dart';

// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

import 'my_pages5/user_info.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
  final bool page = true;
  void increment() {
    print('ss');
  }
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBar_back,
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 15, right: 15),
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(color: AppColors.appBar_back),
            child: Stack(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
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
        preferredSize: Size.fromHeight(100),
      ),
      body: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: ListView(
          children: <Widget>[
            Container(
              height: 150,
              margin: const EdgeInsets.only(top: 15),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/ban1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                margin: const EdgeInsets.only(left: 15, right: 15),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(top: 15),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/ban2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 15, right: 7.5),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(top: 15),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/ban3.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 15, left: 7.5),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            (Constants.discount_products.length != 0)
                ? const Arzan()
                : Container(),
            const SizedBox(
              height: 25,
            ),
            MainCat(),
            (Constants.categoryhome != null)
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: Constants.categoryhome.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      int id = Constants.categoryhome[index].id;
                      return (index != 1)
                          ? Container(
                              height: 360,
                              margin: EdgeInsets.only(bottom: 10, top: 10),
                              child: Column(
                                children: <Widget>[
                                  Harytlar(
                                      Constants.categoryhome[index].id,
                                      Constants.categoryhome[index].name_tm,
                                      Constants.categoryhome[index].name_ru,
                                      Constants.categoryhome[index].children),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  HomeItemPage(id),
                                ],
                              ),
                            )
                          : Container(
                              height: 505,
                              margin: EdgeInsets.only(bottom: 10, top: 10),
                              child: Column(
                                children: <Widget>[
                                  Harytlar(
                                      Constants.categoryhome[index].id,
                                      Constants.categoryhome[index].name_tm,
                                      Constants.categoryhome[index].name_ru,
                                      Constants.categoryhome[index].children),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  HomeItemPage(id),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: (() {
                                      if (Constants.token == '') {
                                        Constants.which_sign = false;
                                        Provider.of<BottomProv>(context,
                                                listen: false)
                                            .set_ver_false();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Page4()));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserInf()));
                                      }
                                    }),
                                    child: Container(
                                      height: 125,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/slider_350.png'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        margin: const EdgeInsets.only(
                                            left: 15, right: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  )
                : Container(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
