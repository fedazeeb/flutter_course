import 'package:course/models/item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List<Item> _items = [];
  double _price = 0.0;
  String _category = "Samsung";

  void add(Item item) {
    //////////////////////////////////////////////////////
    bool ifexist = true;
    _items.forEach((element) {
      if (element.name == item.name) {
        int index = _items.indexOf(element);
        _items[index].count += 1;
        print("fdgdfg");
        ifexist = false;
        //item.count = item.count + 1;
      }
    });
    if (ifexist) {
/////////////////////////////////////////////////////////
      _items.add(item);
    }
    print(_items[0].count);
    _price += item.price!;
    notifyListeners();
  }

  void delte(/*int i*/ Item item) {
    int i = _items.indexWhere((element) => element.name == item.name);
    ///////////////////////////////////////////////////////////
    if (i != -1) {
      if (_items[i].count > 1) {
        _items[i].count -= 1;
        _price -= _items[i].price!;
      } else {
        ///////////////////////////////////////////////////////////
        _price -= _items[i].price!;
        _items.removeAt(i);
      }
    }
    notifyListeners();
  }

  void deleteItem(Item item) {
    int i = _items.indexWhere((element) => element.name == item.name);
    _items.removeAt(i);
    notifyListeners();
  }

  void updateCountOfItem(Item item) {
    int i = _items.indexWhere((element) => element.name == item.name);

    print(_items[i].count);
    _items[i].count = item.count;
   _price += (item.price! * item.count);

    notifyListeners();
  }

  Future<void> deletePrice(Item item) async {
    int i = _items.indexWhere((element) => element.name == item.name);

    double old_price = (_items[i].price! * _items[i].count);
    _price -= old_price;

    notifyListeners();
  }

  void changecategory(String c) {
    _category = c;
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  int countOfOneItem(Item item) {
    final index = _items.indexWhere((element) => element.name == item.name);
    if (index >= 0) {
      print('Using indexWhere:');
      return _items[index].count;
    }

    return 0;
  }

  List<Item> get allitem {
    return _items;
  }

  double get totalprice {
    return _price;
  }

  List<Item> get getbasket {
    return _items;
  }

  String get getcategory {
    return _category;
  }
}
