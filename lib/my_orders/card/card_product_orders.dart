import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/values/colors.dart';

import '../../providers/page1provider.dart';
import '../../values/models.dart';

class CardProductOrders extends StatefulWidget {
  List<order_items> product;
  int index;
  CardProductOrders(this.product, this.index);

  @override
  _CardProductOrdersState createState() => _CardProductOrdersState();
}

class _CardProductOrdersState extends State<CardProductOrders> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.light_silver,
                ),
                child: Divider(
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
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl: widget.product[widget.index].image,
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.local_dining),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              (Provider.of<Which_page>(context).dil != 0)
                                  ? widget.product[widget.index].name_tm
                                  : widget.product[widget.index].name_ru,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 10),
                            // ignore: prefer_const_constructors
                            child: Text(
                              '${widget.product[widget.index].price}  TMT / ${widget.product[widget.index].count}${(Provider.of<Which_page>(context).dil != 0) ? ' sany' : ' шт'} ',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            )
          ],
        ));
  }
}
