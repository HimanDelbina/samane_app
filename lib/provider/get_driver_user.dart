import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:samane_app/model/driver_user_model.dart';
import 'package:samane_app/static/url.dart';
import 'package:samane_app/static/user_static.dart';

class GetDriverUser extends ChangeNotifier {
  List<DriverUserModel> _map = [];
  bool _error = false;
  bool _refresh = false;
  String _errorMessage = "";
  List<DriverUserModel> get map => _map;
  bool get error => _error;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;

  Future<List<DriverUserModel>?> get fetchData async {
    _refresh = true;
    var response = await http.get(
        Uri.parse(StaticUrlFile.url.toString() +
            "/company/get_driver_users/" +
            StaticUserFile.user_id.toString()),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    _refresh = false;
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        _map = driverUserModelFromJson(x);
        print(_map);
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = [];
      }
    } else {
      _error = false;
      _errorMessage = "Error : Conection Error";
      _map = [];
    }
    notifyListeners();
  }

  void initialValues() {
    _map = [];
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }
}
