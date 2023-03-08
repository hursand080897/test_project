import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport/values/models.dart';

import '../values/colors.dart';

// ignore: must_be_immutable
class FutbolOptions extends StatelessWidget {
  ModelFutbol products;
  FutbolOptions(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(color: Colors.white),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.lightSilver,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  'assets/images/back.svg',
                  color: Colors.black,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(100),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            Text(
              products.name,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontFamily: 'Semi',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              products.image,
              height: 180,
              width: 180,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              products.description,
              maxLines: 20,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
