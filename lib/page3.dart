// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/page4.dart';
import 'package:injir_new/provider_bloc/cart_items/cart_bloc.dart';
import 'package:injir_new/providers/bottom_prov.dart';
import 'package:injir_new/providers/provider_items.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/my_pages3/karzina_card.dart';
import 'package:injir_new/my_pages3/send_order.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/colors.dart';
import 'package:injir_new/values/constants.dart' as Constants;

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Which_page>(context);
    if (prov.dil != 0) {
      Constants.dil = true;
    } else {
      Constants.dil = false;
    }
    //String skidka=(Provider.of<Which_page>(context).price-Provider.of<Which_page>(context).total_price).toStringAsFixed(2);
    String skidka = '0';

    return Scaffold(
        appBar: PreferredSize(
          // ignore: sort_child_properties_last
          child: SafeArea(
            child: Container(
              height: 60,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: AppColors.appBar_back),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      prov.dil != 0 ? 'Sebet' : 'Корзина',
                      style: const TextStyle(
                          fontFamily: 'Semi',
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              BlocProvider.of<CartBloc>(context)
                                  .add(CartClearProductsEvent());
                            }),
                            child: Container(
                                height: 45,
                                width: 45,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(100),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            print('huwwaaaawa');
            return state.products.isNotEmpty
                ? Container(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        // ignore: prefer_const_constructors
                        SliverList(
                            delegate: SliverChildListDelegate(List.generate(
                                context
                                    .select((CartBloc bloc) => bloc.state.myid)
                                    .length, (idx) {
                          final cardItem = context
                              .select((CartBloc bloc) => bloc.state.products);
                          final myId = context
                              .select((CartBloc bloc) => bloc.state.myid);
                          return KarzinaCard(cardItem[myId[idx]]!);
                        }))),

                        SliverToBoxAdapter(
                          child: const SizedBox(
                            height: 25,
                          ),
                        ),

                        SliverToBoxAdapter(
                          child: Visibility(
                            visible: false,
                            child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 25, left: 10, right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: AppColors.silver)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            (prov.dil != 0)
                                                ? Constants.tm_product_price
                                                : Constants.ru_product_price,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            // ignore: prefer_interpolation_to_compose_strings
                                            Provider.of<ProvItem>(context)
                                                    .price
                                                    .toStringAsFixed(2) +
                                                'TMT',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'Semi'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            (prov.dil != 0)
                                                ? Constants.tm_extra_info
                                                : Constants.ru_extra_info,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            (Provider.of<ProvItem>(context)
                                                        .price >
                                                    Provider.of<Which_page>(
                                                            context)
                                                        .dostawka_min)
                                                ? '0 TMT'
                                                : Provider.of<Which_page>(
                                                            context)
                                                        .dostawka_price
                                                        .toStringAsFixed(2) +
                                                    'TMT',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'Semi'),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // ignore: prefer_const_constructors

                                    const SizedBox(
                                      height: 25,
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            (prov.dil != 0)
                                                ? Constants.tm_discount_info
                                                : Constants.ru_discount_info,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            Provider.of<ProvItem>(context)
                                                    .dis
                                                    .toStringAsFixed(2) +
                                                'TMT',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'Semi'),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 25,
                                    ),

                                    Container(
                                      height: 2,
                                      // ignore: prefer_const_constructors
                                      decoration: BoxDecoration(
                                        color: AppColors.silver,
                                      ),
                                      child: const Divider(
                                        height: 2,
                                        color: AppColors.light_silver,
                                      ),
                                    ),

                                    // ignore: prefer_const_constructors

                                    const SizedBox(
                                      height: 25,
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          // ignore: prefer_const_constructors
                                          Text(
                                            (prov.dil != 0)
                                                ? Constants.tm_net_price
                                                : Constants.ru_net_price,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: 'Semi'),
                                          ),
                                          // ignore: prefer_const_constructors
                                          Text(
                                            (Provider.of<ProvItem>(context)
                                                        .price <
                                                    Provider.of<Which_page>(
                                                            context)
                                                        .dostawka_min)
                                                ? (Provider.of<ProvItem>(
                                                                    context)
                                                                .total_price +
                                                            Provider.of<Which_page>(
                                                                    context)
                                                                .dostawka_price)
                                                        .toStringAsFixed(2) +
                                                    'TMT'
                                                : Provider.of<ProvItem>(context)
                                                        .total_price
                                                        .toStringAsFixed(2) +
                                                    'TMT',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: 'Semi'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),

                        // ignore: prefer_const_constructors
                        SliverToBoxAdapter(
                          child: const SizedBox(
                            height: 25,
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        SliverToBoxAdapter(
                          child: const SizedBox(
                            height: 25,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            height: 100,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            decoration:
                                BoxDecoration(color: AppColors.appBar_back),
                            child: GestureDetector(
                              onTap: (() {
                                if (Constants.token != '') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SendOrder()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Page4()));
                                }
                              }),
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // ignore: prefer_const_constructors
                                child: Text(
                                  (prov.dil != 0)
                                      ? Constants.tm_order
                                      : Constants.ru_order,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Semi'),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ignore: prefer_const_constructors
                        SliverToBoxAdapter(
                          child: const SizedBox(
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 35),
                          child: SvgPicture.asset(
                            'assets/images/empty_cart.svg',
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                        Text(
                          Provider.of<Which_page>(context).dil != 0
                              ? 'Siziň sebediňiz boş!'
                              : 'Ваша корзина пуста',
                          style: TextStyle(
                              fontFamily: 'Semi',
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<BottomProv>(context, listen: false)
                                .set_page0();
                          },
                          child: Container(
                            width: 220,
                            height: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 35),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // ignore: prefer_const_constructors
                            child: Text(
                              (prov.dil != 0) ? 'Haryt goş' : 'Добавить товар',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Semi'),
                            ),
                          ),
                        ),
                      ],
                    ));
          },
        ));
  }
}
