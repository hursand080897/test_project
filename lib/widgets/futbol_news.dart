import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/values/colors.dart';
import 'package:sport/widgets/futbol_options.dart';

import '../provider_bloc/futbol/futbol_news_bloc.dart';
import '../values/models.dart';

class FutbolNews extends StatelessWidget {
  const FutbolNews({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: BlocBuilder<FutbolNewsBloc, FutbolNewsState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.listFutbol.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return CartNews(state.listFutbol[index]);
            },
          );
        },
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Do you want to logout?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes'),
                ),
              ],
            ));
    return Future.value(true);
  }
}

// ignore: must_be_immutable
class CartNews extends StatelessWidget {
  ModelFutbol list;
  // ignore: use_key_in_widget_constructors
  CartNews(this.list, {Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FutbolOptions(list)),
        );
      }),
      child: Container(
        height: 180,
        margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 0), // changes position of shadow
              )
            ]),
        child: Row(
          children: [
            Image.asset(
              list.image,
              height: 180,
              width: 180,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              list.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontFamily: 'Semi',
              ),
            )),
          ],
        ),
      ),
    );
  }
}
