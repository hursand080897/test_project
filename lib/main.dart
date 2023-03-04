import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injir_new/my_orders/main_orders.dart';
import 'package:injir_new/my_pages/categories.dart';
import 'package:injir_new/my_pages/my_favourites.dart';
import 'package:injir_new/my_pages2/sub_cat.dart';
import 'package:injir_new/my_pages2/subcategory.dart';
import 'package:injir_new/my_pages4/verify.dart';
import 'package:injir_new/options_item.dart';
import 'package:injir_new/page1.dart';
import 'package:injir_new/page3.dart';
import 'package:injir_new/page4.dart';
import 'package:injir_new/page5.dart';
import 'package:injir_new/provider_bloc/cart_items/cart_bloc.dart';
import 'package:injir_new/provider_bloc/favourite_items/favourites_bloc.dart';
import 'package:injir_new/providers/bottom_prov.dart';
import 'package:injir_new/providers/favourite.dart';
import 'package:injir_new/providers/page1provider.dart';
import 'package:injir_new/providers/page1settings.dart';
import 'package:injir_new/providers/provider_items.dart';
import 'package:injir_new/providers/user_info.dart';
import 'package:injir_new/splash.dart';
import 'package:injir_new/test/testing.dart';
import 'package:injir_new/values/colors.dart';
import 'package:provider/provider.dart';
import 'my_pages/bash sahypa/search.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartBloc(),
          ),
          BlocProvider(
            create: (context) => FavouritesBloc(),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Which_page()),
            ChangeNotifierProvider(create: (_) => Favourite()),
            ChangeNotifierProvider(create: (_) => BottomProv()),
            ChangeNotifierProvider(create: (_) => PageSettings()),
            ChangeNotifierProvider(create: (_) => UserInfo()),
            ChangeNotifierProvider(create: (_) => ProvItem()),
          ],
          child: const MyApp(),
        ),
      ),
    );

typedef parentFunctionCallback = void Function();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Monto'),
      initialRoute: '/splash',
      routes: {
        '/home': (context) => const MyHomePage(),
        '/splash': (context) => const Splash(),
        '/options_item': (context) => const OptionsItem(),
        '/verify': (context) => const Verify(),
        '/page4': (context) => const Page4(),
        '/test': (context) => const Testing(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Controller to handle PageView and also handles initial page
  var _pageController = PageController(initialPage: 0);

  GlobalKey<NavigatorState> _yourKey = GlobalKey<NavigatorState>();
  int which_page = 1;
  int maxCount = 5;
  int t = 0;
  static int _favor_page = 0;

  /// widget list

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _backPressed(GlobalKey<NavigatorState> _yourKey) async {
    print(_yourKey.currentState!);
    /*
    return 
   */
    if (_yourKey.currentState!.canPop()) {
      // 'maybePop' method handles the decision of 'pop' to another WillPopScope if they exist.
      //If no other WillPopScope exists, it returns true
      _yourKey.currentState!.maybePop();
      return Future<bool>.value(false);
    }
//if nothing remains in the stack, it simply pops
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text((Provider.of<Which_page>(context).dil != 0)
                ? 'Siz ulgamdan çykmak isleýäňizmi?'
                : 'Вы хотите выйти?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text((Provider.of<Which_page>(context).dil != 0)
                    ? 'Ýok'
                    : 'Нет'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text((Provider.of<Which_page>(context).dil != 0)
                    ? 'Howa'
                    : 'Да'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomBarPages = [
      Navigator(
        key: Provider.of<BottomProv>(context).yourKey1,
        onGenerateRoute: (settings) {
          Widget page = const Page1();
          if (settings.name == 'options') page = const OptionsItem();
          if (settings.name == '/searchin') page = const Search();
          if (settings.name == '/subcat') page = SubCat();
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
      Navigator(
        key: Provider.of<BottomProv>(context).yourKey2,
        onGenerateRoute: (settings) {
          Widget page = const Categories();
          if (settings.name == '/subcat') page = SubCat();
          if (settings.name == '/subcats') page = const Subcategory();
          if (settings.name == '/options') page = const OptionsItem();
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
      Navigator(
        key: Provider.of<BottomProv>(context).yourKey3,
        onGenerateRoute: (settings) {
          Widget page = Page3();
          if (settings.name == '/optionsim') page = const OptionsItem();
          if (settings.name == '/my_order') page = const MainOrders();
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
      Navigator(
        key: Provider.of<BottomProv>(context).yourKey4,
        onGenerateRoute: (settings) {
          Widget page = MyFavourites();
          if (settings.name == '/favor_options') page = const OptionsItem();
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
      Navigator(
        key: Provider.of<BottomProv>(context).yourKey5,
        onGenerateRoute: (settings) {
          print(settings.name);
          Widget page = Page5();
          if (settings.name == '/favor') page = MyFavourites();
          if (settings.name == '/page4') page = Page4();

          return MaterialPageRoute(builder: (_) => page);
        },
      ),
    ];
    return WillPopScope(
      onWillPop: () => _backPressed(
          (Provider.of<BottomProv>(context, listen: false).page != 0)
              ? Provider.of<BottomProv>(context, listen: false).yourKey
              : Provider.of<BottomProv>(context, listen: false).yourKey1),
      child: Scaffold(
        body: PageView(
          controller: Provider.of<BottomProv>(context).pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          height: 70,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        which_page = 1;
                        Provider.of<BottomProv>(context, listen: false)
                            .set_page0();
                      },
                      child: Container(
                        color: Color.fromARGB(0, 255, 255, 255),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            (Provider.of<BottomProv>(context).page == 0)
                                ? Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primary,
                                    ),
                                  )
                                : Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                  ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/man1.svg',
                                      color: (Provider.of<BottomProv>(context)
                                                  .page ==
                                              0)
                                          ? AppColors.primary
                                          : AppColors.silver,
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                    Text(
                                      (Provider.of<Which_page>(context).dil !=
                                              0)
                                          ? 'Baş sahypa'
                                          : 'Главная страница',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: "Semi",
                                          color:
                                              (Provider.of<BottomProv>(context)
                                                          .page ==
                                                      0)
                                                  ? AppColors.primary
                                                  : AppColors.silver),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        which_page = 2;
                        Provider.of<BottomProv>(context, listen: false)
                            .setPage1();
                      },
                      child: Container(
                        color: Color.fromARGB(0, 255, 255, 255),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            (Provider.of<BottomProv>(context).page == 1)
                                ? Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primary,
                                    ),
                                  )
                                : Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                  ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/man2.svg',
                                      color: (Provider.of<BottomProv>(context)
                                                  .page ==
                                              1)
                                          ? AppColors.primary
                                          : AppColors.silver,
                                      allowDrawingOutsideViewBox: true,
                                    ),
                                    Text(
                                      (Provider.of<Which_page>(context).dil !=
                                              0)
                                          ? 'Kategoriyalar'
                                          : 'Категории',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: "Semi",
                                          color:
                                              (Provider.of<BottomProv>(context)
                                                          .page ==
                                                      1)
                                                  ? AppColors.primary
                                                  : AppColors.silver),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        which_page = 3;
                        Provider.of<BottomProv>(context, listen: false)
                            .setPage2();
                      },
                      child: Container(
                        color: Color.fromARGB(0, 255, 255, 255),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            (Provider.of<BottomProv>(context).page == 2)
                                ? Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primary,
                                    ),
                                  )
                                : Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                  ),
                            Expanded(
                              child: BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) {
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        (state.myid.isNotEmpty)
                                            ? (Provider.of<BottomProv>(context)
                                                        .page ==
                                                    2)
                                                ? SvgPicture.asset(
                                                    'assets/images/man3_added_selected.svg',
                                                    allowDrawingOutsideViewBox:
                                                        true,
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/images/man3_added.svg',
                                                    allowDrawingOutsideViewBox:
                                                        true,
                                                  )
                                            : SvgPicture.asset(
                                                'assets/images/man3.svg',
                                                color: (Provider.of<BottomProv>(
                                                                context)
                                                            .page ==
                                                        2)
                                                    ? AppColors.primary
                                                    : AppColors.silver,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                        Text(
                                          (Provider.of<Which_page>(context)
                                                      .dil !=
                                                  0)
                                              ? 'Sebet'
                                              : 'Корзина',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: "Semi",
                                              color: (Provider.of<BottomProv>(
                                                              context)
                                                          .page ==
                                                      2)
                                                  ? AppColors.primary
                                                  : AppColors.silver),
                                        ),
                                      ]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        which_page = 4;
                        Provider.of<BottomProv>(context, listen: false)
                            .setPage3();
                      },
                      child: Container(
                        color: Color.fromARGB(0, 255, 255, 255),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            (Provider.of<BottomProv>(context).page == 3)
                                ? Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primary,
                                    ),
                                  )
                                : Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                  ),
                            Expanded(
                              child:
                                  BlocBuilder<FavouritesBloc, FavouritesState>(
                                builder: (context, state) {
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        state.myid.isNotEmpty
                                            ? (Provider.of<BottomProv>(context)
                                                        .page ==
                                                    3)
                                                ? SvgPicture.asset(
                                                    'assets/images/man4_added_selected.svg',
                                                    allowDrawingOutsideViewBox:
                                                        true,
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/images/man4_added.svg',
                                                    allowDrawingOutsideViewBox:
                                                        true,
                                                  )
                                            : SvgPicture.asset(
                                                'assets/images/man4.svg',
                                                color: (Provider.of<BottomProv>(
                                                                context)
                                                            .page ==
                                                        3)
                                                    ? AppColors.primary
                                                    : AppColors.silver,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              ),
                                        Text(
                                          (Provider.of<Which_page>(context)
                                                      .dil !=
                                                  0)
                                              ? 'Halanlarym'
                                              : 'Избранное',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: "Semi",
                                              color: (Provider.of<BottomProv>(
                                                              context)
                                                          .page ==
                                                      3)
                                                  ? AppColors.primary
                                                  : AppColors.silver),
                                        ),
                                      ]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print('tap');
                        which_page = 5;
                        setState(() {
                          _favor_page = 1;
                        });
                        Provider.of<BottomProv>(context, listen: false)
                            .setPage4();
                      },
                      child: Container(
                        color: Color.fromARGB(0, 255, 255, 255),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            (Provider.of<BottomProv>(context).page == 4)
                                ? Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primary,
                                    ),
                                  )
                                : Container(
                                    height: 6,
                                    width: 26,
                                    margin: const EdgeInsets.only(top: 5),
                                  ),
                            Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.settings_outlined,
                                        color: (Provider.of<BottomProv>(context)
                                                    .page ==
                                                4)
                                            ? AppColors.primary
                                            : AppColors.silver),
                                    Text(
                                      (Provider.of<Which_page>(context).dil !=
                                              0)
                                          ? 'Sazlamalar'
                                          : 'Настройки',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: "Semi",
                                          color:
                                              (Provider.of<BottomProv>(context)
                                                          .page ==
                                                      4)
                                                  ? AppColors.primary
                                                  : AppColors.silver),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
