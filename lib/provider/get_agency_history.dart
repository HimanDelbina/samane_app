import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:samane_app/model/agency_history_model.dart';
import 'package:samane_app/static/url.dart';

class GetAgencyHistory extends ChangeNotifier {
  List<AgencyHistoryModel> _map = [];
  bool _error = false;
  bool _refresh = false;
  String _errorMessage = "";
  List<AgencyHistoryModel> get map => _map;
  bool get error => _error;
  bool get refresh => _refresh;
  String get errorMessage => _errorMessage;

  // var x = json.decode(response.body);
  // boperationList = x.map((e) => Boperation.fromJson(e)).toList();
  Future<List<AgencyHistoryModel>?> get fetchData async {
    _refresh = true;
    var response = await http.get(
        Uri.parse(StaticUrlFile.url.toString() + "/agency/get_agencyuser_all"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    _refresh = false;
    if (response.statusCode == 200) {
      try {
        var x = response.body;
        _map = agencyHistoryModelFromJson(x);
        print(_map);
        // var x = json.decode(response.body);
        // _map = x.map((e) => AgencyModel.fromJson(e)).toList();
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
