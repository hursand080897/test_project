part of 'cart_bloc.dart';

class CartState {
  final Map<int, Products> products;
  final List myid;
  final double total_price;
  CartState({
    this.products = const {},
    this.myid = const [],
    this.total_price = 0.00,
  });

  CartState copyWith({
    Map<int, Products>? products,
    List? myid,
    double? total_price,
  }) {
    return CartState(
      products: products ?? this.products,
      myid: myid ?? this.myid,
      total_price: total_price ?? this.total_price,
    );
  }
}

class Products {
  int id;
  final String name_tm;
  final String name_ru;
  final description_tm;
  final description_ru;
  final String image;
  final double price;
  final int count;
  final double rating;
  final int discount;
  final double discount_price;
  final String category;
  var values;
  Products({
    this.id = 0,
    this.name_tm = '',
    this.name_ru = '',
    this.description_tm = '',
    this.description_ru = '',
    this.image = '',
    this.price = 0.00,
    this.count = 0,
    this.rating = 0.00,
    this.discount = 0,
    this.discount_price = 0.00,
    this.category = '',
    this.values = const [],
  });
  factory Products.fromLocal(List<Products> local, int type, int total) {
    return Products(
      id: local[0].id,
      name_tm: local[0].name_tm,
      name_ru: local[0].name_ru,
      description_tm: local[0].description_tm ?? '',
      description_ru: local[0].description_ru ?? '',
      image: local[0].image,
      price: local[0].price,
      count: type == 0
          ? local[0].count
          : type == 1
              ? total + 1
              : total - 1,
      rating: local[0].rating,
      discount: local[0].discount,
      discount_price: local[0].discount_price,
      category: local[0].category,
      values: local[0].values ?? '',
    );
  }
}
