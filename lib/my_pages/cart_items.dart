import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/options_item.dart';
import 'package:injir_new/provider_bloc/cart_items/cart_bloc.dart';
import 'package:injir_new/provider_bloc/favourite_items/favourites_bloc.dart';
import 'package:injir_new/providers/favourite.dart';
import 'package:injir_new/providers/provider_items.dart';
import 'package:injir_new/values/colors.dart';

import 'package:injir_new/values/constants.dart' as Constants;
import 'package:provider/provider.dart';

import '../providers/page1provider.dart';

// ignore: must_be_immutable
class CartItems extends StatelessWidget {
  Products products;
  CartItems(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Container(
      width: 190,
      margin: const EdgeInsets.only(left: 5, right: 5),
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OptionsItem()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 135,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.fitHeight,
                            imageUrl: '${products.image}',
                            errorWidget: (context, url, error) =>
                                new Image.asset(
                              'assets/images/check.png',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(right: 16, top: 6),
                        child: GestureDetector(
                          onTap: (() {
                            BlocProvider.of<FavouritesBloc>(context)
                                .add(FavouritesClickProductEvent(products));
                          }),
                          child: BlocBuilder<FavouritesBloc, FavouritesState>(
                            builder: (context, state) {
                              return Container(
                                child: context.select((FavouritesBloc bloc) =>
                                        bloc.state.products
                                            .containsKey(products.id))
                                    ? const Icon(
                                        Icons.favorite,
                                        color: AppColors.primary,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.black,
                                      ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (products.discount != 0)
                      ? Row(
                          children: [
                            Container(
                              width: 50,
                              height: 20,
                              margin:
                                  const EdgeInsets.only(left: 18, right: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '- ${products.discount}%',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Semi'),
                              ),
                            ),
                            Text(
                              '${products.price}TMT',
                              style: const TextStyle(
                                  color: AppColors.silver,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: 'Semi'),
                            ),
                          ],
                        )
                      : Container(
                          height: 20,
                        ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 18, right: 18),
                    child: Text(
                      (Provider.of<Which_page>(context).dil != 0)
                          ? products.name_tm
                          : products.name_ru,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    )),
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 18),
                child: (products.discount != 0)
                    ? Text(
                        '${products.discount_price}TMT',
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "MBold",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        '${products.price}TMT',
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "MBold",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(height: 8),
              context.select((CartBloc bloc) =>
                      bloc.state.products.containsKey(products.id))
                  ? Container(
                      height: 40,
                      margin: const EdgeInsets.only(
                          left: 18, right: 18, bottom: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromRGBO(248, 248, 248, 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<CartBloc>(context)
                                      .add(CartDecProductEvent(products));
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
                            child: Center(
                              child: Text(
                                context.select((CartBloc bloc) => bloc
                                        .state.products
                                        .containsKey(products.id))
                                    ? context
                                        .select((CartBloc bloc) => bloc
                                            .state.products[products.id]!.count)
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
                                      .add(CartIncProductEvent(products));
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
                    )
                  : GestureDetector(
                      onTap: () {
                        BlocProvider.of<CartBloc>(context)
                            .add(CartIncProductEvent(products));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 40,
                            margin: const EdgeInsets.only(
                                left: 18, right: 18, bottom: 10),
                            alignment: Alignment.center,
                            // ignore: prefer_const_constructors
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: AppColors.primary,
                            ),
                            child: Text(
                              Provider.of<Which_page>(context).dil != 0
                                  ? 'Sebede goş'
                                  : 'В корзину',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Semi'),
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
