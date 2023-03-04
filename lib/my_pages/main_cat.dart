import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/constants.dart' as Constants;

import '../my_pages2/subcategory.dart';
import '../values/models.dart';

class MainCat extends StatefulWidget {
  const MainCat({Key? key}) : super(key: key);

  @override
  _MainCatState createState() => _MainCatState();
}

class _MainCatState extends State<MainCat> {
  List<categorys> child = [];
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Which_page>(context);
    return Container(
      height: 140,
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  (prov.dil != 0)
                      ? Constants.tm_category
                      : Constants.ru_category,
                  style: const TextStyle(
                      fontSize: 18, fontFamily: "Semi", color: Colors.black),
                )
              ],
            ),
          ),
          SizedBox(
            height: 90,
            child: ListView.builder(
                itemCount: Constants.category.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      Constants.children = Constants.category[index].children;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Subcategory()));
                    },
                    child: Container(
                      width: 130,
                      height: 100,
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 100,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                fit: BoxFit.fitHeight,
                                imageUrl: '{widget}',
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/cat_image.png',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 130,
                            height: 100,
                            padding: const EdgeInsets.only(
                                right: 25, left: 10, top: 8),
                            child: Text(
                              (prov.dil != 0)
                                  ? Constants.category[index].name_tm
                                  : Constants.category[index].name_ru,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'Semi'),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

//  imageUrl: '${Constants.category[index].image}',
/*
 (prov.dil != 0)
                                ? Constants.category[index].name_tm
                                : Constants.category[index].name_ru,
                                */