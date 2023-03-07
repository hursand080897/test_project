import 'package:flutter/material.dart';
import 'package:project/values/colors.dart';

class CheckInternet extends StatelessWidget {
  const CheckInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/logo.png',
            height: 150,
            width: 150,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const CircularProgressIndicator(
          strokeWidth: 5.0,
          color: AppColors.primary,
          semanticsLabel: 'Circular progress indicator',
        ),
      ],
    );
  }
}
