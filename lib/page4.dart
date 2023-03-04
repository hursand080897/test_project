// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:injir_new/providers/bottom_prov.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/my_pages4/verify.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/colors.dart';
import 'package:http/http.dart' as http;
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

import 'DB/db.dart';

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  bool sign = Constants.which_sign;
  TextEditingController loginName =
      TextEditingController(text: Constants.phone);
  TextEditingController regName = TextEditingController();
  TextEditingController regSurname = TextEditingController();
  TextEditingController regEmail = TextEditingController();
  TextEditingController regPhone = TextEditingController();
  TextEditingController regName1 = TextEditingController(text: Constants.name1);
  TextEditingController regSurname1 =
      TextEditingController(text: Constants.name2);
  TextEditingController regEmail1 =
      TextEditingController(text: Constants.email);
  TextEditingController regPhone1 =
      TextEditingController(text: Constants.phone);
  bool loading = false;

  Future sending(String name) async {
    //if (name=="")name=Constants.pname;
    var headers = {
      "phone": name,
    };

    var url = Uri.http(Constants.api, '/api/v1/login');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url, body: headers);
    if (response.statusCode == 200) {
      Constants.phone = name;
      print(headers);
      setState(() {
        loading = false;
      });

      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Verify()));
    } else {
      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Siz registrasiya boldunyzmy?"),
      ));
    }
  }

  Future delete_accaunt() async {
    Map<String, String> header = {'Authorization': 'Bearer ${Constants.token}'};
    var response = await http.delete(
        Uri.http(Constants.api, '/api/v1/users/me/destroy'),
        headers: header);
    var mitem = json.decode(utf8.decode(response.bodyBytes));
    print(Constants.token);
    print(mitem);
    print(response.statusCode);

    if (response.statusCode == 200) {
      Constants.name = '';
      Constants.token = '';
      Constants.email = '';
      Constants.phone = '';
      DatabaseHelper.deleteUserAll();
      setState(() {
        loginName = TextEditingController();
      });
    } else {
      print('Error');
    }
  }

  String gmail = '';
  String mail = '';
  // ignore: non_constant_identifier_names
  Future reg_sending(
      String name, String surname, String email, String phone) async {
    //if (name=="")name=Constants.pname;
    int i = 0;
    if ((surname.length != 0) &&
        (name.length != 0) &&
        (email.length != 0) &&
        (phone.length > 7)) {
      if (email.contains('@')) {
        var headers = {
          "name": name,
          "surname": surname,
          "email": email,
          "phone": phone,
        };
        //21789
        //61415232
        var url = Uri.http(Constants.api, '/api/v1/register');
        Constants.phone = phone;
        print('$phone');
        // Await the http get response, then decode the json-formatted response.
        var response = await http.post(url, body: headers);
        if (response.statusCode == 200) {
          setState(() {
            loading = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Verify()));
        } else {
          setState(() {
            loading = false;
          });
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Siz hasaba alynan"),
          ));
        }
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Mailiňizi dogry giriziň"),
        ));
      }
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Doly dolduryň"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Which_page>(context);
    print('objectjsjsjsjsjsjsjsjsjsjsjs');
    if (Provider.of<BottomProv>(context).ver) {
      setState(() {
        regName1 = TextEditingController(text: Constants.name1);
        regSurname1 = TextEditingController(text: Constants.name2);
        regEmail1 = TextEditingController(text: Constants.email);
        regPhone1 = TextEditingController(text: Constants.phone);
      });
      return Scaffold(
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 35, right: 35),
              child: Center(
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Container(
                              height: 100,
                              width: 100,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: AppColors.silver,
                                borderRadius: BorderRadius.circular(75),
                              ),
                              child: Image.asset(
                                'assets/images/profil.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: regName1,
                            style: TextStyle(color: AppColors.primary),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.primary,
                                ),
                                labelStyle:
                                    new TextStyle(color: AppColors.primary),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: AppColors.primary)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.25))),
                                hintStyle: new TextStyle(
                                  inherit: true,
                                  fontSize: 14.0,
                                  fontFamily: "WorkSansLight",
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                                hintText: (prov.dil != 0)
                                    ? Constants.tm_name
                                    : Constants.ru_name),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: regSurname1,
                            style: TextStyle(color: AppColors.primary),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.primary,
                                ),
                                labelStyle:
                                    new TextStyle(color: AppColors.primary),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: AppColors.primary)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.25))),
                                hintStyle: new TextStyle(
                                  inherit: true,
                                  fontSize: 14.0,
                                  fontFamily: "WorkSansLight",
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                                hintText: (prov.dil != 0)
                                    ? Constants.tm_surname
                                    : Constants.ru_surname),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: regEmail1,
                            style: TextStyle(color: AppColors.primary),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: AppColors.primary,
                                ),
                                labelStyle:
                                    new TextStyle(color: AppColors.primary),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: AppColors.primary)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.25))),
                                hintStyle: new TextStyle(
                                  inherit: true,
                                  fontSize: 14.0,
                                  fontFamily: "WorkSansLight",
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                                hintText: 'Email'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: regPhone1,
                            style: TextStyle(color: AppColors.primary),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                // ignore: prefer_const_constructors
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: AppColors.primary,
                                ),
                                labelStyle:
                                    new TextStyle(color: AppColors.primary),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: AppColors.primary)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 0.25))),
                                hintStyle: new TextStyle(
                                  inherit: true,
                                  fontSize: 14.0,
                                  fontFamily: "WorkSansLight",
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                                hintText: '6* ** ** **'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (Provider.of<BottomProv>(context).reg)
                                  ? GestureDetector(
                                      onTap: (() async {
                                        Map<String, String> header = {
                                          'Authorization':
                                              'Bearer ${Constants.token}'
                                        };
                                        var url = Uri.http(Constants.api,
                                            '/api/v1/users/me/destroy');
                                        // Await the http get response, then decode the json-formatted response.
                                        var response = await http.delete(url,
                                            headers: header);
                                        print(response.statusCode);
                                        if (response.statusCode == 204) {
                                          DatabaseHelper.deleteUserAll();
                                          setState(() {
                                            Constants.phone = '';
                                            Constants.token = '';
                                            Constants.name = '';
                                            Constants.name1 = '';
                                            Constants.name2 = '';
                                            Constants.email = '';
                                            regName1 = TextEditingController(
                                                text: Constants.name1);
                                            regSurname1 = TextEditingController(
                                                text: Constants.name2);
                                            regEmail1 = TextEditingController(
                                                text: Constants.email);
                                            regPhone1 = TextEditingController(
                                                text: Constants.phone);
                                          });
                                          Provider.of<BottomProv>(context,
                                                  listen: false)
                                              .set_reg(false);

                                          // ignore: prefer_const_constructors, use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                "Siz ulgamdan çykdyňyz!"),
                                          ));
                                        } else {
                                          // ignore: prefer_const_constructors, use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                "Ýalňyşlyk ýüze çykdy täzeden synanyşyň!"),
                                          ));
                                        }
                                      }),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          height: 60,
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(
                                              bottom: 10, left: 20, right: 20),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            (Provider.of<Which_page>(context)
                                                        .dil !=
                                                    0)
                                                ? 'Hasaby pozmak'
                                                : 'Удалить аккаунт',
                                            style: TextStyle(
                                                fontFamily: 'Semi',
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
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
                      margin: const EdgeInsets.only(top: 40, left: 10),
                      color: Color.fromARGB(0, 255, 255, 255),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      if (!sign) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 35, right: 35),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/idris_logo.png',
                        height: 180,
                        width: 130,
                      ),
                      TextField(
                        controller: loginName,
                        style: TextStyle(color: AppColors.primary),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(bottom: 4),
                            width: 70,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: AppColors.primary,
                                ),
                                Text(
                                  '+993',
                                  style: TextStyle(
                                      color: AppColors.primary, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          labelStyle: new TextStyle(
                              color: AppColors.primary, fontSize: 14),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: AppColors.primary)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.25))),
                          hintStyle: TextStyle(
                            inherit: true,
                            fontSize: 14.0,
                            fontFamily: "WorkSansLight",
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!loading) {
                                sending(loginName.text);
                              }
                              setState(() {
                                loading = true;
                              });
                            },
                            child: Container(
                              width: 220,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8)),
                              child: (!loading)
                                  ? Text(
                                      (prov.dil != 0)
                                          ? Constants.tm_login
                                          : Constants.ru_login,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: 'Semi'),
                                    )
                                  : LinearProgressIndicator(
                                      minHeight: 15,
                                      value: animation.value,
                                      color: AppColors.light_silver,
                                      backgroundColor: AppColors.primary,
                                      semanticsLabel:
                                          'Linear progress indicator',
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (prov.dil != 0)
                                ? Constants.tm_did_login
                                : Constants.ru_did_login,
                            style: TextStyle(
                              color: AppColors.silver,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: (() {
                              print('tap');
                              setState(() {
                                sign = true;
                              });
                            }),
                            child: Text(
                              (prov.dil != 0)
                                  ? Constants.tm_sign
                                  : Constants.ru_sign,
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontFamily: 'Semi'),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                        margin: const EdgeInsets.only(top: 40, left: 10),
                        color: Color.fromARGB(0, 255, 255, 255),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Scaffold(
          body: Stack(
            children: [
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
                        margin: const EdgeInsets.only(top: 40, left: 10),
                        color: Color.fromARGB(0, 255, 255, 255),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 35, right: 35),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'assets/images/idris_logo.png',
                      height: 100,
                      width: 100,
                    ),
                    TextFormField(
                      controller: regName,
                      style: TextStyle(color: AppColors.primary),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          labelStyle: new TextStyle(color: AppColors.primary),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: AppColors.primary)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.25))),
                          hintStyle: new TextStyle(
                            inherit: true,
                            fontSize: 14.0,
                            fontFamily: "WorkSansLight",
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                          hintText: (prov.dil != 0)
                              ? Constants.tm_name
                              : Constants.ru_name),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: regSurname,
                      style: TextStyle(color: AppColors.primary),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          labelStyle: new TextStyle(color: AppColors.primary),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: AppColors.primary)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.25))),
                          hintStyle: new TextStyle(
                            inherit: true,
                            fontSize: 14.0,
                            fontFamily: "WorkSansLight",
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                          hintText: (prov.dil != 0)
                              ? Constants.tm_surname
                              : Constants.ru_surname),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: regEmail,
                      style: TextStyle(color: AppColors.primary),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: AppColors.primary,
                          ),
                          labelStyle: new TextStyle(color: AppColors.primary),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: AppColors.primary)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.25))),
                          hintStyle: new TextStyle(
                            inherit: true,
                            fontSize: 14.0,
                            fontFamily: "WorkSansLight",
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                          hintText: 'Email'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: regPhone,
                      style: TextStyle(color: AppColors.primary),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          // ignore: prefer_const_constructors
                          prefixIcon: Icon(
                            Icons.phone,
                            color: AppColors.primary,
                          ),
                          labelStyle: new TextStyle(color: AppColors.primary),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: AppColors.primary)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.25))),
                          hintStyle: new TextStyle(
                            inherit: true,
                            fontSize: 14.0,
                            fontFamily: "WorkSansLight",
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                          hintText: '6* ** ** **'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!loading) {
                              reg_sending(regName.text, regSurname.text,
                                  regEmail.text, regPhone.text);
                            } else {
                              print('-----------------------------object');
                            }
                            setState(() {
                              loading = true;
                            });
                          },
                          child: Container(
                            width: 220,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8)),
                            // ignore: prefer_const_constructors
                            child: (!loading)
                                ? Text(
                                    (prov.dil != 0)
                                        ? Constants.tm_sign
                                        : Constants.ru_sign,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontFamily: 'Semi'),
                                  )
                                : LinearProgressIndicator(
                                    minHeight: 15,
                                    value: animation.value,
                                    color: AppColors.light_silver,
                                    backgroundColor: AppColors.primary,
                                    semanticsLabel: 'Linear progress indicator',
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (prov.dil != 0)
                              ? Constants.tm_did_signin
                              : Constants.ru_did_signin,
                          style: TextStyle(
                            color: AppColors.silver,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: (() {
                            print('tap');
                            setState(() {
                              sign = false;
                            });
                          }),
                          child: Text(
                            (prov.dil != 0)
                                ? Constants.tm_login
                                : Constants.ru_login,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 10,
                                fontFamily: 'Semi'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
  }
}
