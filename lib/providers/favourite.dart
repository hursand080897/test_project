import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:injir_new/DB/db.dart';
import 'package:injir_new/values/models.dart';

class Favourite with ChangeNotifier, DiagnosticableTreeMixin {
  List _myid = [];
  List get myid => _myid;

  String phone = "";
  Map<int, products> _items = {};

  Map<int, products> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addSplash(
      int id,
      String name_tm,
      String name_ru,
      var description_tm,
      var description_ru,
      String image,
      double price,
      int count,
      double rating,
      int discount,
      double discount_price,
      String category,
      var values) {
    if (_items.containsKey(id)) {
    } else {
      _myid.add(id);
      _items.putIfAbsent(
        id,
        () => products(
            id: id,
            name_tm: name_tm,
            name_ru: name_ru,
            description_tm: description_tm,
            description_ru: description_ru,
            image: image,
            price: price,
            count: count,
            rating: rating,
            discount: discount,
            discount_price: discount_price,
            category: category,
            values: values),
      );
      notifyListeners();
    }
  }

  void addItem(
      int id,
      String name_tm,
      String name_ru,
      var description_tm,
      var description_ru,
      String image,
      double price,
      int count,
      double rating,
      int discount,
      double discount_price,
      String category,
      var values) {
    _myid.add(id);
    DatabaseHelper.createFavor(
        id,
        name_tm,
        name_ru,
        description_tm,
        description_ru,
        image,
        price,
        count,
        rating,
        discount,
        discount_price,
        category);
    _items.putIfAbsent(
      id,
      () => products(
          id: id,
          name_tm: name_tm,
          name_ru: name_ru,
          description_tm: description_tm,
          description_ru: description_ru,
          image: image,
          price: price,
          count: count,
          rating: rating,
          discount: discount,
          discount_price: discount_price,
          category: category,
          values: values),
    );
    notifyListeners();
  }

  void removeItem(int id) {
    _myid.remove(id);
    DatabaseHelper.deleteFavor(id);
    _items.remove(id);

    notifyListeners();
  }
}
