part of 'cart_bloc.dart';

class CartState {
  final String url;
  final bool loading;
  final bool connection;
  final bool plug;
  CartState({
    this.url = '',
    this.loading = true,
    this.connection = true,
    this.plug = false,
  });

  CartState copyWith({
    String? url,
    bool? loading,
    bool? connection,
    bool? plug,
  }) {
    return CartState(
        url: url ?? this.url,
        loading: loading ?? this.loading,
        connection: connection ?? this.connection,
        plug: plug ?? this.plug);
  }
}
