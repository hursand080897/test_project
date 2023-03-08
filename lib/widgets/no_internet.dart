import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/provider_bloc/cart_items/cart_bloc.dart';
import 'package:sport/values/colors.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/no_internet.webp'),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Internet connection lost !',
          style: TextStyle(color: Colors.black, fontFamily: 'Semi'),
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<CartBloc>(context).add(CartFetchEvent());
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              'TRY AGAIN',
              style: TextStyle(color: Colors.white, fontFamily: 'Semi'),
            ),
          ),
        )
      ],
    );
  }
}
