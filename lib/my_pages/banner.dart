import 'package:banner_image/banner_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:injir_new/values/colors.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

final list = [
  "assets/images/cafebar.png",
  "assets/images/cafebar.png",
  "assets/images/cafebar.png",
  "assets/images/cafebar.png",
];

class BannerScreen extends StatefulWidget {
  const BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BannerImage(
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.only(),
            itemLength:
                (Constants.banner.length != 0) ? Constants.banner.length : 2,
            // ignore: sort_child_properties_last
            children: List.generate(
              (Constants.banner.length != 0) ? Constants.banner.length : 2,
              (index) => CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: (Constants.banner.length != 0)
                    ? Constants.banner[index].image
                    : 'https//images.logo',
                errorWidget: (context, url, error) =>
                    new Icon(Icons.local_dining),
              ),
            ),
            selectedIndicatorColor: AppColors.appBar_back,
            withOutIndicator: true,
            autoPlay: true,
            onTap: (int index) {
              //
            },
          ),
        ],
      ),
    );
  }
}

class HorizontalBannerScreen extends StatefulWidget {
  const HorizontalBannerScreen({Key? key}) : super(key: key);

  @override
  State<HorizontalBannerScreen> createState() => _HorizontalBannerScreenState();
}

class _HorizontalBannerScreenState extends State<HorizontalBannerScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BannerImage(
            padding: const EdgeInsets.only(),
            itemLength: list.length,
            // ignore: sort_child_properties_last
            children: List.generate(
              list.length,
              (index) => Image.asset(
                list[index],
                fit: BoxFit.cover,
              ),
            ),
            selectedIndicatorColor: Colors.red,
            autoPlay: true,
            scrollDirection: Axis.vertical,
          ),
          const SizedBox(height: 15),
          BannerImage(
            itemLength: list.length,
            // ignore: sort_child_properties_last
            children: List.generate(
              list.length,
              (index) => Image.asset(
                list[index],
                fit: BoxFit.cover,
              ),
            ),
            borderRadius: BorderRadius.circular(8),
            selectedIndicatorColor: Colors.blue,
            indicatorColor: Colors.green.shade100,
            scrollDirection: Axis.vertical,
          ),
          const SizedBox(height: 15),
          BannerImage(
            aspectRatio: 2,
            itemLength: list.length,
            borderRadius: BorderRadius.circular(8),
            // ignore: sort_child_properties_last
            children: List.generate(
              list.length,
              (index) => Image.asset(
                list[index],
                fit: BoxFit.cover,
              ),
            ),
            selectedIndicatorColor: Colors.red,
            withOutIndicator: true,
            scrollDirection: Axis.vertical,
          ),
          const SizedBox(height: 15),
          BannerImage(
            aspectRatio: 20 / 10,
            itemLength: list.length,
            borderRadius: BorderRadius.circular(8),
            // ignore: sort_child_properties_last
            children: List.generate(
              list.length,
              (index) => Image.asset(
                list[index],
                fit: BoxFit.cover,
              ),
            ),
            selectedIndicatorColor: Colors.red,
            scrollDirection: Axis.vertical,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BannerImage(
              aspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height),
              padding: const EdgeInsets.only(),
              itemLength: list.length,
              // ignore: sort_child_properties_last
              children: List.generate(
                list.length,
                (index) => Image.asset(
                  list[index],
                  fit: BoxFit.cover,
                ),
              ),
              selectedIndicatorColor: Colors.red,
              autoPlay: false,
              withOutIndicator: true,
              fit: BoxFit.scaleDown,
            ),
          ],
        ),
      ),
    );
  }
}
