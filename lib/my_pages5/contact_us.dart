import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/colors.dart';

// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 55,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    color: Color.fromARGB(0, 255, 255, 255),
                    // ignore: prefer_const_constructors
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: (() {}),
                  // ignore: prefer_const_constructors
                  child: Text(
                    (Provider.of<Which_page>(context).dil != 0)
                        ? Constants.tm_contuct_us
                        : Constants.ru_contuct_us,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
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
        padding: EdgeInsets.only(left: 50, right: 50),
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Image.asset(
              'assets/images/my_logo.png',
              width: 170,
              height: 170,
            ),
            const SizedBox(
              height: 25,
            ),
            // ignore: prefer_const_constructors
            Text(
              'Lebap Welaýaty',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              ' Bahar kiçi etrapça, S.A.Niýazow şaýoly, Türkmenabat ş',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Image.asset('assets/images/email.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'info@lebapdlbsf.com.tm',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Image.asset('assets/images/contuct_us.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '+933 63 60 68 53',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Image.asset('assets/images/contuct_us.png'),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '+933 422 2 41 69',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
