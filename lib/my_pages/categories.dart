import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/my_pages/banner.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/my_pages/category_cart.dart';
import 'package:injir_new/providers/page1provider.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

import '../values/colors.dart';
import 'bash sahypa/search.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool stat = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('yes');
        return Navigator.canPop(context);
      },
      child: Scaffold(
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
          padding:
              const EdgeInsets.only(bottom: 15, top: 5, left: 15, right: 15),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    (Provider.of<Which_page>(context).dil != 0)
                        ? Constants.tm_category
                        : Constants.ru_category,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Semi',
                    ),
                  )),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const BannerScreen(),
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          mainAxisExtent:
                              200, // here set custom Height You Want
                        ),
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        primary: false,
                        itemCount: Constants.category.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CategoryCart(
                            Constants.category[index].id,
                            Constants.category[index].name_tm,
                            Constants.category[index].name_ru,
                            Constants.category[index].image,
                            Constants.category[index].children,
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
