import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/options_item.dart';
import 'package:injir_new/providers/provider_items.dart';
import 'package:injir_new/values/colors.dart';
import 'package:injir_new/values/constants.dart' as Constants;
import 'package:provider/provider.dart';

import '../providers/page1provider.dart';

class CardUni extends StatefulWidget {
  int id;
  String name_tm;
  String name_ru;
  String description_tm;
  String description_ru;
  String image;
  double price;
  int count;
  double rating;
  int discount;
  double discount_price;
  String category;
  var values;
  CardUni(
      this.id,
      this.name_tm,
      this.name_ru,
      this.description_tm,
      this.description_ru,
      this.image,
      this.price,
      this.count,
      this.rating,
      this.discount,
      this.discount_price,
      this.category,
      this.values);

  @override
  _CardUniState createState() => _CardUniState();
}

class _CardUniState extends State<CardUni> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.only(left: 5, right: 5),
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Constants.op_id = widget.id;
          Constants.op_name_tm = widget.name_tm;
          Constants.op_name_ru = widget.name_ru;
          Constants.op_description_tm = widget.description_tm;
          Constants.op_description_ru = widget.description_ru;
          Constants.op_image = widget.image;
          Constants.op_price = widget.price;
          Constants.op_count = widget.count;
          Constants.op_rating = widget.rating;
          Constants.op_discount = widget.discount;
          Constants.op_discount_price = widget.discount_price;
          Constants.op_category = widget.category;
          Constants.op_values = widget.values;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OptionsItem()),
          );
        },
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
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 5),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.image,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // ignore: prefer_const_constructors
                                  child: Text(
                                    (Provider.of<Which_page>(context).dil != 0)
                                        ? widget.name_tm
                                        : widget.name_ru,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'Semi'),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    (widget.discount != 0)
                                        ? Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 20,
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  '- ${widget.discount}%',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: 'Semi'),
                                                ),
                                              ),
                                              Text(
                                                '${widget.price}TMT',
                                                style: const TextStyle(
                                                  color: AppColors.silver,
                                                  fontSize: 14,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            height: 20,
                                          ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // ignore: prefer_const_constructors
                                  child: (widget.discount != 0)
                                      ? Text(
                                          '${widget.discount_price} TMT',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'MBold'),
                                        )
                                      : Text(
                                          '${widget.price} TMT',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'MBold',
                                          ),
                                        ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        height: 120,
                        alignment: Alignment.center,
                        child: Provider.of<ProvItem>(context)
                                    .items[widget.id]
                                    ?.count ==
                                null
                            ? GestureDetector(
                                onTap: () {
                                  Provider.of<ProvItem>(context, listen: false)
                                      .addItem(
                                          widget.id,
                                          widget.name_tm,
                                          widget.name_ru,
                                          widget.description_tm,
                                          widget.description_ru,
                                          widget.image,
                                          widget.price,
                                          widget.count,
                                          widget.rating,
                                          widget.discount,
                                          widget.discount_price,
                                          widget.category,
                                          widget.values);
                                },
                                child: Container(
                                  height: 30,
                                  width: 120,
                                  alignment: Alignment.center,
                                  // ignore: prefer_const_constructors
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: AppColors.primary,
                                  ),
                                  child: const Text(
                                    'В корзину',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Semi'),
                                  ),
                                ),
                              )
                            : Container(
                                height: 30,
                                width: 120,
                                alignment: Alignment.centerLeft,
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
                                            widget.count--;
                                            print('minus${widget.count}');
                                            Provider.of<ProvItem>(context,
                                                    listen: false)
                                                .removeItem(
                                                    widget.id, widget.count);
                                            setState(() => widget.count);
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
                                          (Provider.of<ProvItem>(context,
                                                          listen: false)
                                                      .items[widget.id]
                                                      ?.count ==
                                                  null)
                                              ? '0'
                                              : Provider.of<ProvItem>(context,
                                                      listen: false)
                                                  .items[widget.id]!
                                                  .count
                                                  .toString(),
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
                                            widget.count++;
                                            Provider.of<ProvItem>(context,
                                                    listen: false)
                                                .addItem(
                                                    widget.id,
                                                    widget.name_tm,
                                                    widget.name_ru,
                                                    widget.description_tm,
                                                    widget.description_ru,
                                                    widget.image,
                                                    widget.price,
                                                    widget.count,
                                                    widget.rating,
                                                    widget.discount,
                                                    widget.discount_price,
                                                    widget.category,
                                                    widget.values);
                                            setState(() => widget.count);
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
                              ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
/*
      
       
*/