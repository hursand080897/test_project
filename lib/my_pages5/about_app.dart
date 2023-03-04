import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/colors.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBar_back,
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
                        ? 'Programma barada'
                        : 'О программе',
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
        color: Color.fromRGBO(241, 241, 241, 1),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Image.asset('assets/images/idris_logo.png',
                width: 170, height: 170),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Tazelenen versiyasy 1.0.0',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
