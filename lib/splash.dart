import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/provider_bloc/cart_items/cart_bloc.dart';
import 'package:project/widgets/check_internet.dart';
import 'package:project/widgets/no_internet.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: context.select(((CartBloc bloc) => bloc.state.loading))
              ? const CheckInternet()
              : context.select(((CartBloc bloc) => !bloc.state.connection))
                  ? const NoInternet()
                  : Container(),
        ));
  }
}
