import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injir_new/provider_bloc/favourite_items/favourites_bloc.dart';
import 'package:provider/provider.dart';
import 'package:injir_new/providers/favourite.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/values/colors.dart';
// ignore: library_prefixes
import 'package:injir_new/values/constants.dart' as Constants;
import 'package:injir_new/my_pages/cart_items.dart';

class MyFavourites extends StatefulWidget {
  @override
  _MyFavouritesState createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Favourite>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        // ignore: sort_child_properties_last
        child: SafeArea(
          child: Container(
            height: 60,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: AppColors.appBar_back),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    Provider.of<Which_page>(context).dil != 0
                        ? Constants.tm_favourites
                        : Constants.ru_favourites,
                    style: const TextStyle(
                        fontFamily: 'Semi', fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            color: Colors.white,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 320,
                ),
                itemCount: state.myid.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CartItems(state.products[state.myid[index]]!);
                }),
          );
        },
      ),
    );
  }
}
