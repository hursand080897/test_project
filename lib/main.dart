import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/provider_bloc/cart_items/cart_bloc.dart';
import 'package:project/provider_bloc/futbol/futbol_news_bloc.dart';
import 'package:project/repository/locator.dart';
import 'package:project/widgets/check_internet.dart';
import 'package:project/widgets/futbol_news.dart';
import 'package:project/widgets/no_internet.dart';
import 'package:project/widgets/webview.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CartBloc()..add(CartFetchEvent()),
        ),
        BlocProvider(
          create: (context) => FutbolNewsBloc()..add(FutbolFetchEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Monto'),
        home: const Main(),
      ),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
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
                  : context.select(((CartBloc bloc) => bloc.state.plug))
                      ? const FutbolNews()
                      : WebView(),
        ));
  }
}
