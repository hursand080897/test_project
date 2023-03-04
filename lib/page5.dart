import 'package:flutter/material.dart';
import 'package:injir_new/DB/db.dart';
import 'package:injir_new/my_pages5/my_news.dart';
import 'package:injir_new/my_pages5/user_info.dart';
import 'package:injir_new/page4.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/providers/bottom_prov.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/providers/page1settings.dart';
import 'package:injir_new/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/my_pages5/about_app.dart';
import 'package:injir_new/my_pages5/help.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

import 'my_orders/main_orders.dart';

class Page5 extends StatefulWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  _Page5State createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Which_page>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                (Provider.of<BottomProv>(context).reg)
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 25, bottom: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.light_silver),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (prov.dil != 0)
                                  ? 'Has köp aýratynlyklary ulanmak üçin ulgama giriň'
                                  : 'Войдите, чтобы использовать больше функций',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.primary),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Constants.which_sign = false;
                                      Provider.of<BottomProv>(context,
                                              listen: false)
                                          .set_ver_false();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Page4()));
                                    },
                                    child: Container(
                                        color: Colors.transparent,
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          (prov.dil != 0)
                                              ? Constants.tm_login
                                              : Constants.ru_login,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily: 'Semi'),
                                        )),
                                  )),
                                  Container(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      Constants.which_sign = true;
                                      Provider.of<BottomProv>(context,
                                              listen: false)
                                          .set_ver_false();
                                      Navigator.pushNamed(context, '/page4');
                                    },
                                    child: Container(
                                        color: Colors.transparent,
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          (prov.dil != 0)
                                              ? Constants.tm_sign
                                              : Constants.ru_sign,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily: 'Semi'),
                                        )),
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                (Provider.of<BottomProv>(context).reg)
                    ? _tile(
                        '1',
                        (prov.dil != 0) ? 'Profil' : 'Профиль',
                        'assets/images/login.svg',
                      )
                    : Container(),
                _tile(
                    '11',
                    (prov.dil != 0)
                        ? Constants.tm_favourites
                        : Constants.ru_favourites,
                    'assets/images/favourite.svg'),
                _tile(
                    '7',
                    (prov.dil != 0)
                        ? Constants.tm_about_us
                        : Constants.ru_about_us,
                    'assets/images/info.svg'),
                _tile(
                    '12',
                    (prov.dil != 0)
                        ? Constants.tm_discounts
                        : Constants.ru_discounts,
                    'assets/images/aksiya.svg'),
                _tile(
                    '4',
                    (prov.dil != 0) ? Constants.tm_orders : Constants.ru_orders,
                    'assets/images/my_orders.svg'),
                _tile(
                    '5',
                    (prov.dil != 0)
                        ? Constants.tm_language
                        : Constants.ru_language,
                    'assets/images/language.svg'),
                _tile(
                    '6',
                    (prov.dil != 0) ? Constants.tm_help : Constants.ru_help,
                    'assets/images/help.svg'),
                _tile('13', (prov.dil != 0) ? 'Jaň et' : 'Позвонить',
                    'assets/images/call.svg'),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  alignment: Alignment.center,
                  child: Text(
                    Provider.of<Which_page>(context).dil != 0
                        ? '1.0 wersiýa belgisi'
                        : 'Версия номер 1.0',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                (Provider.of<BottomProv>(context).reg)
                    ? GestureDetector(
                        onTap: (() {
                          DatabaseHelper.deleteUserAll();
                          setState(() {
                            Constants.phone = '';
                            Constants.token = '';
                            Constants.name = '';
                            Constants.name1 = '';
                            Constants.name2 = '';
                            Constants.email = '';
                          });
                          Provider.of<BottomProv>(context, listen: false)
                              .set_reg(false);
                          // ignore: prefer_const_constructors, use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("Siz ulgamdan çykdyňyz!"),
                          ));
                        }),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                bottom: 10, left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              (Provider.of<Which_page>(context).dil != 0)
                                  ? 'Ulgamdan çykmak'
                                  : 'Выйти',
                              style: TextStyle(
                                  fontFamily: 'Semi', color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _tile extends StatefulWidget {
  String id;
  String name;
  String icon;
  _tile(this.id, this.name, this.icon);

  @override
  State<_tile> createState() => __tileState();
}

class __tileState extends State<_tile> {
  void pushNav() {
    if (widget.id == "1") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserInf()));
    }
    if (widget.id == "2") {
      Constants.which_sign = true;
      Provider.of<BottomProv>(context, listen: false).set_ver_false();
      Navigator.pushNamed(context, '/page4');
    }
    if (widget.id == "3") {
      Constants.which_sign = false;
      Provider.of<BottomProv>(context, listen: false).set_ver_false();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Page4()));
    }
    if (widget.id == "4") {
      Provider.of<PageSettings>(context, listen: false).set_page0();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainOrders()));
    }

    if (widget.id == "5") {
      _dialogBuilder(context);
    }
    if (widget.id == "66") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
    }
    if (widget.id == "7") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutApp()),
      );
    }
    if (widget.id == "11") {
      Provider.of<BottomProv>(context, listen: false).setPage3();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('object');
        pushNav();
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: SvgPicture.asset(
                    widget.icon,
                    height: 20,
                    width: 20,
                    color: AppColors.primary,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(
              left: 7,
              right: 7,
            ),
            child: Container(
              height: 1,
              color: AppColors.light_silver,
            ),
          ),
        ],
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            fontFamily: 'Semi',
                            color: AppColors.primary,
                            fontSize: 16),
                      ),
                      child: Text(
                        (Provider.of<Which_page>(context).dil != 0)
                            ? 'Dil saýlaň'
                            : 'Выберите язык',
                        style: TextStyle(
                            fontFamily: 'Semi',
                            color: AppColors.primary,
                            fontSize: 16),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          child: SvgPicture.asset(
                            'assets/images/language_selected.svg',
                            color: Provider.of<Which_page>(context).dil != 0
                                ? AppColors.primary
                                : AppColors.silver,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'Türkmen dili',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Provider.of<Which_page>(context, listen: false)
                                .setTm();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          child: SvgPicture.asset(
                            'assets/images/language_selected.svg',
                            color: Provider.of<Which_page>(context).dil == 0
                                ? AppColors.primary
                                : AppColors.silver,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'Русский',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Provider.of<Which_page>(context, listen: false)
                                .setRu();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
