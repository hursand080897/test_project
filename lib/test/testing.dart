import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injir_new/providers/page4provider.dart';
import 'package:injir_new/test/user_bloc/user_bloc.dart';
import 'package:photo_view/photo_view.dart';

import '../providers/item_bloc.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    // final bloc = ItemBloc()..add(CounterIncEvent());
    final counterBloc = ItemBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(
          create: (context) => counterBloc,
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(counterBloc),
        )
      ],
      child: Builder(builder: (context) {
        print('scaf');
        final bloc = BlocProvider.of<ItemBloc>(context);
        final userBloc = BlocProvider.of<UserBloc>(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Title'),
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      bloc.add(CounterIncEvent());
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.red,
                      child: const Text('+'),
                    )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      bloc.add(CounterDecEvent());
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.red,
                      child: const Text('-'),
                    )),
                GestureDetector(
                    onTap: () {
                      userBloc.add(UserGetUsersEvent(bloc.state));
                    },
                    child: Container(
                      height: 40,
                      color: Colors.red,
                      child: const Text('User'),
                    )),
                GestureDetector(
                    onTap: () {
                      userBloc.add(UserGetUsersJobEvent(bloc.state));
                    },
                    child: Container(
                      height: 40,
                      color: Colors.red,
                      child: const Text('Job'),
                    )),
                BlocBuilder<ItemBloc, int>(
                    // bloc: bloc,
                    builder: (context, state) {
                  print('hey2');
                  final users = context.select(
                    (UserBloc bloc) => bloc.state.users,
                  );
                  return Column(
                    children: [
                      Text(
                        state.toString(),
                        style: const TextStyle(fontSize: 33),
                      ),
                      if (users.isNotEmpty) ...users.map((e) => Text(e.name)),
                    ],
                  );
                }),
                BlocBuilder<UserBloc, UserState>(
                    // bloc: userBloc,
                    builder: (context, state) {
                  print('hey');
                  //   final users = state.users;
                  final job = state.job;
                  return Column(
                    children: [
                      if (state.isLoading) const CircularProgressIndicator(),
                      // if (users.isNotEmpty)
                      //   ...state.users.map((e) => Text(e.name)),
                      if (job.isNotEmpty) ...state.job.map((e) => Text(e.name)),
                    ],
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
