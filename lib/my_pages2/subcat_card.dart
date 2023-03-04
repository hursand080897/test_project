import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:injir_new/my_pages2/sub_cat.dart';
import 'package:provider/provider.dart';

import '../providers/page1provider.dart';
import '../values/colors.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

class SubcatCard extends StatefulWidget {
  int id;
  String name_tm;
  String name_ru;
  String image;
  var children;
  SubcatCard(this.id, this.name_tm, this.name_ru, this.image, this.children);

  @override
  _SubcatCardState createState() => _SubcatCardState();
}

class _SubcatCardState extends State<SubcatCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Constants.myCatID = widget.id;

        Constants.myCatName =
            (Provider.of<Which_page>(context, listen: false).dil != 0)
                ? widget.name_tm
                : widget.name_ru;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SubCat()));
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(248, 248, 248, 1),
            borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            CachedNetworkImage(
              width: 130,
              height: 130,
              fit: BoxFit.cover,
              imageUrl: '${widget.image}',
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/fruits2.png',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            // ignore: prefer_const_constructors
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
              child: Text(
                (Provider.of<Which_page>(context).dil != 0)
                    ? '${widget.name_tm} '
                    : widget.name_ru,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
