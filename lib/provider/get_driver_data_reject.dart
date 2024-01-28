import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:samane_app/static/url.dart';
import '../model/direction_driver_model.dart';
import '../static/user_static.dart';

class GetDirectionRejectDriver extends ChangeNotifier {
  List<DirectionDriverModel> _map = [];
  bool _error = false;
  int _show_money = 0;
  bool _refresh = false;
  String _errorMessage = "";
  List<DirectionDriverModel> get map => _map;
  bool get error => _error;
  int get show_money => _show_money;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;

  // var x = json.decode(response.body);
  // boperationList = x.map((e) => Boperation.fromJson(e)).toList();
  Future<List<DirectionDriverModel>?> get fetchData async {
    _refresh = true;
    var response = await http.get(
        Uri.parse(StaticUrlFile.url.toString() +
            "/company/get_driver_data_reject"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    _refresh = false;
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        print(x);
        _map = directionDriverModelFromJson(x);

        for (var i = 0; i < _map.length; i++) {
          _show_money = _show_money + int.parse(_map[i].allMoney);
        }
        print(_map);
        // var x = json.decode(response.body);
        // _map = x.map((e) => CartexModel.fromJson(e)).toList();
        _error = false;
        // _refresh = true;
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
