import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injir_new/providers/item_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ItemBloc counterBloc;
  late final StreamSubscription streamSubscription;

  UserBloc(this.counterBloc) : super(UserState()) {
    on<UserGetUsersEvent>(_onGetUser);
    on<UserGetUsersJobEvent>(_onGetUserJob);
    streamSubscription = counterBloc.stream.listen((state) {
      if (state == 0) {
        add(UserGetUsersEvent(0));
        add(UserGetUsersJobEvent(0));
      }
    });
  }

  @override
  Future<void> close() async {
    streamSubscription.cancel();
    return super.close();
  }

  _onGetUser(UserGetUsersEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final users = List.generate(
        event.count, (index) => User(name: 'User name', id: index.toString()));
    emit(state.copyWith(users: users));
  }

  _onGetUserJob(UserGetUsersJobEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final job = List.generate(
        event.count, (index) => Job(name: 'Job name', id: index.toString()));
    emit(state.copyWith(job: job));
  }
}
