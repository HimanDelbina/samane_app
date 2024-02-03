import 'package:flutter/cupertino.dart';
import 'package:samane_app/static/user_driver_static.dart';

import '../model/users_model.dart';

class SetUserAgencyList extends ChangeNotifier {
  List<UsersModel> _items = [];
  List<UsersModel> get items => _items;

  
  void addItem(UsersModel itemData) {
    _items.add(itemData);
    StaticUserDriverFile.user_list_agency.add(itemData);
    notifyListeners();
  }

  void removeItem(UsersModel itemData) {
    _items.remove(itemData);
    StaticUserDriverFile.user_list_agency.remove(itemData);
    notifyListeners();
  }

  List<UsersModel> get basketItem {
    return _items;
  }
}
