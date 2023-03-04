import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../DB/db.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<CartIncProductEvent>(_incProduct);
    on<CartDecProductEvent>(_decProduct);
    on<CartClearProductsEvent>(_clearProducts);
    on<CartAddProductsEvent>(_addProducts);
    on<CartDeleteProductEvent>(_deleteProduct);
  }
  _incProduct(CartIncProductEvent event, Emitter<CartState> emit) {
    final eventItems = event.products;
    final stateItems = state.products;
    if (stateItems.isEmpty) {
      addPlusItem(event, emit);
    } else {
      if (stateItems.containsKey(eventItems.id)) {
        updatePlusItems(event, emit);
      } else {
        addPlusItem(event, emit);
      }
    }
  }

  _decProduct(CartDecProductEvent event, Emitter<CartState> emit) {
    final eventItems = event.products;
    final stateItems = state.products;
    if (stateItems.isNotEmpty) {
      if (stateItems.containsKey(eventItems.id)) {
        if (stateItems[eventItems.id]!.count <= 1) {
          Map<int, Products> items = state.products;
          List myId = state.myid;
          double totalPrice = state.total_price;
          totalPrice = totalPrice - items[event.products.id]!.price;
          items.remove(event.products.id);
          myId.remove(event.products.id);
          DatabaseHelper.deleteItem(event.products.id);
          emit(state.copyWith(
              products: items, myid: myId, total_price: totalPrice));
        } else {
          updateMinusItems(event, emit);
        }
      }
    }
  }

  _clearProducts(CartClearProductsEvent event, Emitter<CartState> emit) {
    final stateItems = state.products;
    if (stateItems.isEmpty) {
      Map<int, Products> items = state.products;
      List myId = state.myid;
      double totalPrice = 0.00;
      items.clear();
      myId.clear();
      DatabaseHelper.deleteItemAll();
      emit(
          state.copyWith(products: items, myid: myId, total_price: totalPrice));
    }
  }

  _deleteProduct(CartDeleteProductEvent event, Emitter<CartState> emit) {
    Map<int, Products> items = state.products;
    List myId = state.myid;
    double totalPrice = state.total_price;
    totalPrice = totalPrice - items[event.products.id]!.price;
    items.remove(event.products.id);
    myId.remove(event.products.id);
    DatabaseHelper.deleteItem(event.products.id);
    emit(state.copyWith(products: items, myid: myId, total_price: totalPrice));
  }

  void addPlusItem(CartIncProductEvent event, Emitter<CartState> emit) {
    Map<int, Products> items = {};
    List myId = [];
    double totalPrice = 0.00;
    if (state.products.isNotEmpty) {
      items = state.products;
      myId = state.myid;
      totalPrice = state.total_price;
    }
    myId.add(event.products.id);
    totalPrice = totalPrice + event.products.price;
    items.putIfAbsent(
      event.products.id,
      () => Products.fromLocal(
          [event.products], 1, items[event.products.id]?.count ?? 0),
    );
    DatabaseHelper.createItem(event.products);
    emit(state.copyWith(products: items, myid: myId, total_price: totalPrice));
  }

  _addProducts(CartAddProductsEvent event, Emitter<CartState> emit) {
    Map<int, Products> items = {};
    List myId = [];
    double totalPrice = 0.00;
    for (int i = 0; i < event.products.length; i++) {
      myId.add(event.products[i].id);
      totalPrice =
          totalPrice + (event.products[i].count * event.products[i].price);
      items.putIfAbsent(
        event.products[i].id,
        () => Products.fromLocal(
            [event.products[i]], 0, items[event.products[i].id]?.count ?? 0),
      );
    }
    emit(state.copyWith(products: items, myid: myId, total_price: totalPrice));
  }

  void updatePlusItems(CartIncProductEvent event, Emitter<CartState> emit) {
    Map<int, Products> items = state.products;
    double totalPrice = state.total_price;
    totalPrice = totalPrice + items[event.products.id]!.price;
    items.update(
      event.products.id,
      (existingCartItem) => Products.fromLocal(
          [event.products], 1, items[event.products.id]!.count),
    );
    DatabaseHelper.updateItem(
        event.products.id, items[event.products.id]!.count);
    emit(state.copyWith(products: items, total_price: totalPrice));
  }

  void updateMinusItems(CartDecProductEvent event, Emitter<CartState> emit) {
    Map<int, Products> items = state.products;
    double totalPrice = state.total_price;
    totalPrice = totalPrice - items[event.products.id]!.price;
    items.update(
      event.products.id,
      (existingCartItem) => Products.fromLocal(
          [event.products], 2, items[event.products.id]!.count),
    );
    DatabaseHelper.updateItem(
        event.products.id, items[event.products.id]!.count);
    emit(state.copyWith(products: items, total_price: totalPrice));
  }
}
