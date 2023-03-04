import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/my_orders/about_products.dart';
import 'package:injir_new/my_orders/contorl_my_order.dart';
import 'package:injir_new/values/colors.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;
import 'package:injir_new/values/models.dart';

import '../../providers/page1provider.dart';

class CardOrders extends StatefulWidget {
  List<orders> product;
  int index;
  CardOrders(this.product, this.index);

  @override
  _CardOrdersState createState() => _CardOrdersState();
}

class _CardOrdersState extends State<CardOrders> {
  String s_name_tm = '';
  String s_name_ru = '';
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Which_page>(context);
    var card = widget.product[widget.index];

    if (card.status_id == 1) {
      s_name_tm = 'Sargyt barlanýar';
      s_name_ru = 'Заказ в ожидании';
    }
    if (card.status_id == 2) {
      s_name_tm = 'Sargyt tassyklandy';
      s_name_ru = 'Заказ подтвержден';
    }
    if (card.status_id == 3) {
      s_name_tm = 'Sargyt ugradyldy';
      s_name_ru = 'Заказ в пути';
    }
    if (card.status_id == 4) {
      s_name_tm = 'Sargyt gowşuryldy';
      s_name_ru = 'Заказ доставлен';
    }
    if (card.status_id == 5) {
      s_name_tm = 'Sargyt ýatyryldy';
      s_name_ru = 'Заказ отменен';
    }
    return Container(
      height: 200,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              Text(
                widget.product[widget.index].date.toString(),
                // ignore: prefer_const_constructors
                style: TextStyle(
                    color: Colors.black, fontSize: 16, fontFamily: 'Semi'),
              ),
              // ignore: prefer_const_constructors
              Text(
                '${card.total_price} TMT',
                // ignore: prefer_const_constructors
                style: TextStyle(
                    color: AppColors.green, fontSize: 12, fontFamily: 'Semi'),
              ),
            ],
          ),
          Text(
            (prov.dil != 0)
                ? 'Sargydyn №: ${card.order_no}'
                : 'Заказ №: ${card.order_no}',
            style: TextStyle(color: AppColors.silver, fontSize: 14),
          ),
          Text(
            (prov.dil != 0) ? '* $s_name_tm' : '* $s_name_ru',
            style: TextStyle(color: AppColors.green, fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (() {
                    var towarlar = widget.product[widget.index].my_products;

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AboutProducts(towarlar)));
                  }),
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      (prov.dil != 0)
                          ? 'Haryt barada maglumat'
                          : 'Информация о товаре',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Constants.or_status = card.status_id;
                    Constants.or_track_code = card.order_no;
                    Constants.or_total_price = card.total_price;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ContorlMyOrder()));
                  },
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: Text(
                      (prov.dil != 0)
                          ? Constants.tm_control_order
                          : Constants.ru_control_oder,
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
