import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/provider_bloc/cart_items/cart_bloc.dart';
import 'package:project/values/colors.dart';

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
        GestureDetector(
          onTap: () {
            BlocProvider.of<CartBloc>(context).add(CartFetchEvent());
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.only(left: 15, right: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              'Повтарить',
              style: TextStyle(color: Colors.white, fontFamily: 'Semi'),
            ),
          ),
        )
      ],
    );
  }
}
