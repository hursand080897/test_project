part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent {}

// ignore: must_be_immutable
class FavouritesClickProductEvent extends FavouritesEvent {
  Products product;
  FavouritesClickProductEvent(this.product);
}
