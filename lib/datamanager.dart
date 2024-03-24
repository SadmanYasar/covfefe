import 'dart:convert';

import 'datamodel.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  fetchMenu() async {
    const url = "https://firtman.github.io/coffeemasters/api/menu.json";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _menu = [];
        var decodedData = jsonDecode(response.body) as List<dynamic>;
        for (var json in decodedData) {
          _menu?.add(Category.fromJson(json));
        }
      } else {
        throw Exception("Failed to load menu");
      }
    } catch (e) {
      throw Exception("Failed to load menu");
    }
  }

  getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu;
  }

  cartAdd(Product p) {
    bool found = false;
    for (var item in cart) {
      if (item.product.id == p.id) {
        item.quantity++;
        found = true;
      }
    }
    if (!found) {
      cart.add(ItemInCart(product: p, quantity: 1));
    }
  }

  cartRemove(Product product) {
    cart.removeWhere((element) => element.product.id == product.id);
  }

  cartClear() {
    cart.clear();
  }

  double cartTotal() {
    return cart.fold(
        0,
        (previousValue, element) =>
            previousValue + element.product.price * element.quantity);
  }
}
