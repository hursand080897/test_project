import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../cart_items/cart_bloc.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesState()) {
    on<FavouritesClickProductEvent>(_addProduct);
  }
  _addProduct(
      FavouritesClickProductEvent event, Emitter<FavouritesState> emit) {
    final eventItems = event.product;
    final stateItems = state.products;
    if (stateItems.isEmpty) {
      addItem(event, emit);
    } else {
      if (stateItems.containsKey(eventItems.id)) {
        deleteItem(event, emit);
      } else {
        addItem(event, emit);
      }
    }
  }

  void addItem(
      FavouritesClickProductEvent event, Emitter<FavouritesState> emit) {
    Map<int, Products> items = {};
    List myId = [];
    if (state.products.isNotEmpty) {
      items = state.products;
      myId = state.myid;
    }
    print(event.product.id);
    myId.add(event.product.id);

    items.putIfAbsent(
      event.product.id,
      () => Products.fromLocal([event.product], 0, event.product.count),
    );
    print(items[event.product.id]!.id);
    // DatabaseHelper.createItem(event.products);
    emit(state.copyWith(products: items, myid: myId));
  }

  void deleteItem(
      FavouritesClickProductEvent event, Emitter<FavouritesState> emit) {
    Map<int, Products> items = state.products;
    List myId = state.myid;
    items.remove(event.product.id);
    myId.remove(event.product.id);
    // DatabaseHelper.createItem(event.products);
    emit(state.copyWith(products: items, myid: myId));
  }
}
