import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/my_pages2/subcat_card.dart';

// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;
import 'package:provider/provider.dart';

import '../my_pages/banner.dart';
import '../my_pages/bash sahypa/search.dart';
import '../my_pages/category_cart.dart';
import '../providers/page1provider.dart';
import '../values/colors.dart';

class Subcategory extends StatefulWidget {
  const Subcategory({Key? key}) : super(key: key);

  @override
  _SubcategoryState createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
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
          padding:
              const EdgeInsets.only(bottom: 15, top: 5, left: 15, right: 15),
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
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
                          (Provider.of<Which_page>(context).dil != 0)
                              ? Constants.tm_category
                              : Constants.ru_category,
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
                        margin: const EdgeInsets.only(bottom: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Constants.prevCatName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Semi',
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    const BannerScreen(),
                    const SizedBox(
                      height: 20,
                    ),
                    Constants.children != null
                        ? GridView.builder(
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
                            itemCount: Constants.children.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SubcatCard(
                                int.parse(
                                    Constants.children[index]['id'].toString()),
                                Constants.children[index]['name_tm'],
                                Constants.children[index]['name_ru'],
                                Constants.children[index]['image'],
                                Constants.children[index]['children'],
                              );
                            })
                        : Container(),
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
/*
 ListView.builder(
                  itemCount: Constants.children.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SubcatCard(
                      int.parse(Constants.children[index]['id'].toString()),
                      Constants.children[index]['name_tm'],
                      Constants.children[index]['name_ru'],
                      Constants.children[index]['image'],
                      Constants.children[index]['children'],
                    );
                  })
*/