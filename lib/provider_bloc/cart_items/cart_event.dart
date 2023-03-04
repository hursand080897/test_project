part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartIncProductEvent extends CartEvent {
  final Products products;
  CartIncProductEvent(this.products);
}

class CartDecProductEvent extends CartEvent {
  final Products products;
  CartDecProductEvent(this.products);
}

class CartDeleteProductEvent extends CartEvent {
  final Products products;
  CartDeleteProductEvent(this.products);
}

// ignore: must_be_immutable
class CartAddProductsEvent extends CartEvent {
  List<Products> products;
  CartAddProductsEvent(this.products);
}

class CartClearProductsEvent extends CartEvent {}
