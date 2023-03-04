import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:injir_new/providers/provider_items.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/colors.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../my_orders/main_orders.dart';
import '../providers/bottom_prov.dart';

class SendOrder extends StatefulWidget {
  // ignore: non_constant_identifier_names

  @override
  _SendOrderState createState() => _SendOrderState();
}

class _SendOrderState extends State<SendOrder> {
  TextEditingController sendPhone =
      TextEditingController(text: Constants.phone);
  TextEditingController sendName = TextEditingController(text: Constants.name);
  TextEditingController sendAddress = TextEditingController();
  TextEditingController sendDate = TextEditingController();
  TextEditingController sendTime = TextEditingController();
  TextEditingController sendType = TextEditingController();
  TextEditingController sendNote = TextEditingController();

  List<String> list = <String>[
    (Constants.dil != false) ? 'Aşgabat' : 'Ашхабад',
    (Constants.dil != false) ? 'Ahal' : 'Ахал',
    (Constants.dil != false) ? 'Daşoguz' : 'Дашогуз',
    (Constants.dil != false) ? 'Lebap' : 'Лебап',
    (Constants.dil != false) ? 'Mary' : 'Мары',
    (Constants.dil != false) ? 'Balkan' : 'Балкан'
  ];
  String dropdownValue = (Constants.dil != false) ? 'Aşgabat' : 'Ашхабад';
  int which = 0;
  int ii = 1;
  Future<void> sending(String phone, String address, String date, String time,
      String type, String note, BuildContext context) async {
    //if (name=="")name=Constants.pname;
    print('----------$date');
    print('--------$type');

    try {
      print('object1');
      var url = Uri.http(Constants.api, '/api/v1/orders');
      print('object2');
      var token = Constants.token;
      var prov = Provider.of<ProvItem>(context, listen: false);
      print('object3${Constants.token}');

      Map<String, String> data = {
        "full_name": Constants.name,
        "phone": "$phone",
        "address": "$address",
        "note": "$note",
        "date_delivery": '1',
        "payment_method": ii.toString(),
      };
      for (int i = 0; i < prov.myid.length; i++) {
        print(prov.items[prov.myid[i]]!.name_tm);
        data['cart_product_ids[${prov.items[prov.myid[i]]!.id}]'] =
            '${prov.items[prov.myid[i]]!.count}';
      }
      print('object4');
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      print(data);
      var req = http.MultipartRequest('POST', url)
        ..fields.addAll(data)
        ..headers.addAll(headers);
      print('object5');
      var res = await req.send();
      print('object6${res.statusCode}');
      if (res.statusCode == 201) {
        //print('YESSSSSSSSSSSSSSS: ${res.statusCode}.');
        // ignore: use_build_context_synchronously
        Provider.of<Which_page>(context, listen: false).increment_cart();
        Provider.of<ProvItem>(context, listen: false).clearItem();
        _dialogBuilder(context);
      }
    } catch (_) {
      print('_______km_');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Which_page>(context, listen: false);
    var prov_dil = Provider.of<Which_page>(context).dil;

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
                Center(
                  child: Text(
                    (Provider.of<Which_page>(context).dil != 0)
                        ? Constants.tm_send
                        : Constants.ru_send,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 55,
                          width: 55,
                          color: Color.fromARGB(0, 255, 255, 255),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              (prov_dil != 0) ? Constants.tm_type : Constants.ru_type,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        ii = 1;
                      });
                    },
                    child: Container(
                        width: 125,
                        height: 60,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: (ii == 1)
                                ? AppColors.primary
                                : AppColors.light_silver),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/cash.png',
                              height: 20,
                              width: 20,
                              color: (ii == 1) ? Colors.white : Colors.black,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                (prov_dil != 0)
                                    ? Constants.tm_cash
                                    : Constants.ru_cash,
                                style: TextStyle(
                                  color:
                                      (ii == 1) ? Colors.white : Colors.black,
                                  fontFamily: 'Semi',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                // ignore: prefer_const_constructors

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        ii = 2;
                      });
                    },
                    child: Container(
                        width: 125,
                        height: 60,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: (ii == 2)
                                ? AppColors.primary
                                : AppColors.light_silver),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/card.png',
                              height: 20,
                              width: 20,
                              color: (ii == 2) ? Colors.white : Colors.black,
                            ),
                            Container(
                              width: 95,
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                (prov_dil != 0)
                                    ? Constants.tm_kart
                                    : Constants.ru_kart,
                                maxLines: 2,
                                style: TextStyle(
                                  color:
                                      (ii == 2) ? Colors.white : Colors.black,
                                  fontFamily: 'Semi',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              (prov_dil != 0) ? 'Welaýaty saýlaň' : 'Выберите велаят',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: AppColors.light_black,
                    style: BorderStyle.solid,
                    width: 0.80),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                icon: Visibility(
                    visible: false, child: Icon(Icons.arrow_downward)),
                underline: Container(
                  height: 2,
                  color: Color.fromARGB(0, 255, 255, 255),
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                  print(dropdownValue);
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              // ignore: prefer_const_constructors
              controller: sendPhone,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2.0),
                ),
                border: const OutlineInputBorder(),
                hintText: '6* ** ** **',
                labelText: '+993',
                // ignore: prefer_const_constructors
                labelStyle: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              // ignore: prefer_const_constructors
              controller: sendName,

              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2.0),
                ),
                border: const OutlineInputBorder(),

                labelText: (prov_dil != 0) ? 'Adyňyz' : 'Имя',
                // ignore: prefer_const_constructors
                labelStyle: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              // ignore: prefer_const_constructors
              controller: sendAddress,

              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2.0),
                ),
                border: const OutlineInputBorder(),

                labelText:
                    (prov_dil != 0) ? Constants.tm_adres : Constants.ru_adres,
                // ignore: prefer_const_constructors
                labelStyle: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              // ignore: prefer_const_constructors
              controller: sendNote,

              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 2.0),
                ),
                border: const OutlineInputBorder(),

                labelText:
                    (prov_dil != 0) ? Constants.tm_note : Constants.ru_note,
                // ignore: prefer_const_constructors
                labelStyle: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 25, left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.light_silver),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            (Provider.of<ProvItem>(context).price >
                                    Provider.of<Which_page>(context)
                                        .dostawka_min)
                                ? '0 TMT'
                                : Provider.of<Which_page>(context)
                                    .dostawka_price
                                    .toString(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            (Provider.of<ProvItem>(context).price <
                                    Provider.of<Which_page>(context)
                                        .dostawka_min)
                                ? (Provider.of<ProvItem>(context).total_price +
                                            Provider.of<Which_page>(context)
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
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: (() {
                        // ignore: avoid_print
                        print('tapa');
                        sending(
                            sendPhone.text,
                            sendAddress.text,
                            sendDate.text,
                            sendTime.text,
                            dropdownValue,
                            sendNote.text,
                            context);
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        // ignore: prefer_const_constructors
                        child: Text(
                          (prov_dil != 0)
                              ? 'SARGYDY TASSYKLA'
                              : 'ОФОРМИТЬ ЗАКАЗ',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Semi'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              width: 500,
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (Provider.of<Which_page>(context).dil != 0)
                        ? 'Siziň zakazyňyz kabul edildi!'
                        : 'Ваш заказ успешно размещен!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontFamily: 'Semi'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.only(right: 30),
                    child: Image.asset('assets/images/good_order.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    (Provider.of<Which_page>(context).dil != 0)
                        ? 'Sargydyň ýagdaýyny yzarlamak üçin Sargytlarym sahypasyndan barlap bilersiňiz.'
                        : 'Чтобы отслеживать статус заказа, перейдите на История Заказов.',
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        Provider.of<BottomProv>(context, listen: false)
                            .set_page0();
                        Navigator.pop(context);

                        //  Navigator.push(
                        //      context,
                        //      MaterialPageRoute(
                        //          builder: (context) => MainOrders()));
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        color: AppColors.primary,
                        child: Text(
                          (Provider.of<Which_page>(context).dil != 0)
                              ? 'Dowam et'
                              : 'Продолжить',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Semi'),
                        ),
                      )),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
