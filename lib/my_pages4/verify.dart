import 'package:flutter/material.dart';
import 'package:injir_new/my_pages5/user_info.dart';
import 'package:injir_new/page4.dart';
import 'package:injir_new/providers/bottom_prov.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/providers/user_info.dart';
import 'package:injir_new/values/colors.dart';
import 'package:http/http.dart' as http;
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;
import 'package:injir_new/my_pages5/user_info.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../DB/db.dart';
import '../main.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  TextEditingController verifyCode = TextEditingController();

  Future sending(String name) async {
    var headers = {
      "phone": Constants.phone,
      "otp": name,
    };
    var url = Uri.http(Constants.api, '/api/v1/login/verify');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url, body: headers);
    if (response.statusCode == 200) {
      var jsonData = json.decode(utf8.decode(response.bodyBytes));
      var m = jsonData['data'];
      print(m);
      DatabaseHelper.deleteUserAll();
      DatabaseHelper.addUser(m['id'], m['name'], m['surname'], m['email'],
          m['username'], m['api_token']);
      Constants.token = m['api_token'];
      Constants.name = m['name'] + ' ' + m['surname'];
      Constants.name1 = m['name'];
      Constants.name2 = m['surname'];
      Constants.email = m['email'];

      // ignore: prefer_const_constructors, use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Siz ulgamda!"),
      ));
      // ignore: use_build_context_synchronously
      Provider.of<BottomProv>(context, listen: false).set_reg(true);
      Navigator.pop(context);
      print('asd');
      Provider.of<BottomProv>(context, listen: false).set_ver_true();
    } else {
      Constants.phone = "";
      // ignore: use_build_context_synchronously, prefer_const_constructors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Girizen kodynyz ýalňyş"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 55,
            margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Stack(
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
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 35, right: 35, bottom: 20),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/idris_logo.png',
                height: 120,
                width: 120,
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                // ignore: prefer_const_constructors
                child: Text(
                  (Provider.of<Which_page>(context).dil != 0)
                      ? 'Telefonyňyza sms arkaly gelen kody ýazyň *'
                      : 'Введите код подтверждения, отправленный на телефон *',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              TextFormField(
                controller: verifyCode,
                style: TextStyle(color: AppColors.primary),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    // ignore: prefer_const_constructors
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.primary,
                    ),
                    labelStyle: new TextStyle(color: AppColors.primary),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: AppColors.primary)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.25))),
                    // ignore: prefer_const_constructors
                    hintStyle: TextStyle(
                      inherit: true,
                      fontSize: 14.0,
                      fontFamily: "WorkSansLight",
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                    hintText: '** ***'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      sending(verifyCode.text);
                    },
                    child: Container(
                      width: 220,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8)),
                      // ignore: prefer_const_constructors
                      child: Text(
                        (Provider.of<Which_page>(context).dil != 0)
                            ? 'Kody giriz'
                            : 'Введите код',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
