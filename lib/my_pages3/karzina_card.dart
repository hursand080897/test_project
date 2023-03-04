import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/options_item.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/providers/favourite.dart';
import 'package:injir_new/values/colors.dart';

import '../provider_bloc/cart_items/cart_bloc.dart';
import '../providers/page1provider.dart';
import 'package:injir_new/values/constants.dart' as Constants;

class KarzinaCard extends StatelessWidget {
  Products products;
  KarzinaCard(this.products);
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];
    bool art_empty = false;
    return GestureDetector(
      onTap: () {
        Constants.op_id = products.id;
        Constants.op_name_tm = products.name_tm;
        Constants.op_name_ru = products.name_ru;
        Constants.op_description_tm = products.description_tm;
        Constants.op_description_ru = products.description_ru;
        Constants.op_image = products.image;
        Constants.op_price = products.price;
        Constants.op_count = products.count;
        Constants.op_rating = products.rating;
        Constants.op_discount = products.discount;
        Constants.op_discount_price = products.discount_price;
        Constants.op_category = products.category;
        Constants.op_values = products.values;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OptionsItem()));
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Slidable(
          key: ValueKey(products.id),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              BlocProvider.of<CartBloc>(context)
                  .add(CartDeleteProductEvent(products));
            }),
            children: const [
              SlidableAction(
                // An action can be bigger than the others.
                flex: 2,
                onPressed: doNothing,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ],
          ),
          child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 2,
                      decoration: const BoxDecoration(
                        color: AppColors.light_silver,
                      ),
                      child: const Divider(
                        height: 2,
                        color: AppColors.light_silver,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            products.image,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            height: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(left: 10),
                                  // ignore: prefer_const_constructors
                                  child: Text(
                                    (Provider.of<Which_page>(context).dil != 0)
                                        ? products.name_tm
                                        : products.name_ru,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Semi'),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(left: 10),
                                  // ignore: prefer_const_constructors
                                  child: (products.discount != 0)
                                      ? Row(children: [
                                          Text(
                                            '${products.discount_price} TMT',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'MBold'),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            '${products.price} TMT',
                                            style: const TextStyle(
                                                color: AppColors.silver,
                                                fontSize: 16,
                                                fontFamily: 'Semi',
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ])
                                      : Text(
                                          '${products.price} TMT',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'MBold',
                                          ),
                                        ),
                                ),
                                Container(
                                  height: 30,
                                  width: 120,
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromRGBO(248, 248, 248, 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<CartBloc>(context)
                                                  .add(CartDecProductEvent(
                                                      products));
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                'assets/images/minus.svg',
                                                color: AppColors.primary,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            context.select((CartBloc bloc) =>
                                                    bloc
                                                        .state.products
                                                        .containsKey(
                                                            products.id))
                                                ? context
                                                    .select((CartBloc bloc) =>
                                                        bloc
                                                            .state
                                                            .products[
                                                                products.id]!
                                                            .count)
                                                    .toString()
                                                : '0',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'Semi'),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                            onTap: () {
                                              BlocProvider.of<CartBloc>(context)
                                                  .add(CartIncProductEvent(
                                                      products));
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                'assets/images/plus.svg',
                                                color: AppColors.primary,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        height: 120,
                        padding: EdgeInsets.only(
                          right: 15,
                        ),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  if (Provider.of<Favourite>(context,
                                              listen: false)
                                          .items[products.id]
                                          ?.count ==
                                      null) {
                                    Provider.of<Favourite>(context,
                                            listen: false)
                                        .addItem(
                                            products.id,
                                            products.name_tm,
                                            products.name_ru,
                                            products.description_tm,
                                            products.description_ru,
                                            products.image,
                                            products.price,
                                            products.count,
                                            products.rating,
                                            products.discount,
                                            products.discount_price,
                                            products.category,
                                            products.values);
                                  } else {
                                    Provider.of<Favourite>(context,
                                            listen: false)
                                        .removeItem(products.id);
                                  }
                                }),
                                child: Container(
                                  child: (Provider.of<Favourite>(context)
                                              .items[products.id]
                                              ?.count ==
                                          null)
                                      ? const Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                        )
                                      : const Icon(
                                          Icons.favorite,
                                          color: AppColors.primary,
                                        ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(CartDeleteProductEvent(products));
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/images/basket.svg',
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
