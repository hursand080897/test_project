part of 'favourites_bloc.dart';

class FavouritesState {
  final Map<int, Products> products;
  final List myid;
  FavouritesState({
    this.products = const {},
    this.myid = const [],
  });

  FavouritesState copyWith({
    Map<int, Products>? products,
    List? myid,
  }) {
    return FavouritesState(
      products: products ?? this.products,
      myid: myid ?? this.myid,
    );
  }
}
