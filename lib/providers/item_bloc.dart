import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBloc extends Bloc<CounterEvent, int> {
  ItemBloc() : super(5) {
    on<CounterIncEvent>(_onIncrement);
    on<CounterDecEvent>(_onDecrement);
  }
  _onIncrement(CounterIncEvent event, Emitter<int> emit) {
    emit(state + 1);
  }

  _onDecrement(CounterDecEvent event, Emitter<int> emit) {
    if (state <= 0) return;
    emit(state - 1);
  }
}

abstract class CounterEvent {}

class CounterIncEvent extends CounterEvent {}

class CounterDecEvent extends CounterEvent {}
