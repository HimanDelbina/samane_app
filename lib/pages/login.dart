import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:http/http.dart' as http;
import 'package:samane_app/pages/home.dart';
import 'package:samane_app/static/url.dart';
import 'package:samane_app/static/user_static.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  String? company_code;
  TextEditingController controllerCompanyCode = TextEditingController();
  String? password;
  TextEditingController controllerPassword = TextEditingController();

  bool validAndSaveUser() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validAndSubmitUser() {
    if (validAndSaveUser()) {
      // formkey.currentState!.reset();
      loginUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(child: Image.asset("assets/logo.png", height: 80.0)),
                Column(
                  children: [
                    text_form(
                        'کد پرسنلی',
                        'لطفا کد پرسنلی را وارد کنید',
                        IconlyLight.call,
                        controllerCompanyCode,
                        company_code,
                        false),
                    text_form(
                        'رمز',
                        'لطفا رمز را وارد کنید',
                        IconlyLight.password,
                        controllerPassword,
                        password,
                        true),
                    GestureDetector(
                      onTap: () {
                        validAndSubmitUser();
                      },
                      child: Container(
                        height: my_height * 0.07,
                        width: my_width,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Center(
                          child: Text(
                            "ورود",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget text_form(String lable, String erroetext, IconData icon,
      TextEditingController controller, String? save, bool is_show) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        // initialValue: 'رمز',
        keyboardType: TextInputType.number,
        controller: controller,
        onSaved: (value) => save = value,
        obscureText: is_show,
        decoration: InputDecoration(
          labelText: lable,
          errorText: erroetext,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: Icon(icon),
          iconColor: Colors.grey,
        ),
      ),
    );
  }

  var token;
  Future loginUser() async {
    var body = jsonEncode({
      "company_code": controllerCompanyCode.text,
      "password": controllerPassword.text,
    });
    String infourl = StaticUrlFile.url.toString() + '/company/login_user';
    var response = await http.post(Uri.parse(infourl), body: body, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      final SharedPreferences prefsUser = await SharedPreferences.getInstance();
      Map<String, dynamic> result = json.decode(response.body);
      if (result["token"] != null) {
        prefsUser.setString('token', result["token"]);
        prefsUser.setInt('id', result["id"]);
        StaticUserFile.user_id = result["id"];
        prefsUser.setString(
            'first_name', utf8.decode(result["first_name"].codeUnits));
        prefsUser.setString(
            'last_name', utf8.decode(result["last_name"].codeUnits));
        prefsUser.setString('company_code', result["company_code"]);
        prefsUser.setString('post', utf8.decode(result["post"].codeUnits));
        prefsUser.setBool('is_driver', result["is_driver"]);
        prefsUser.setBool('is_admin', result["is_admin"]);
        prefsUser.setBool('is_tell', result["is_tell"]);
        prefsUser.setBool('is_driver_role', result["is_driver_role"]);
        prefsUser.setBool('is_scan', result["is_scan"]);
        prefsUser.setBool('is_pm', result["is_pm"]);
        prefsUser.setBool('is_cartex', result["is_cartex"]);
        prefsUser.setBool('is_store_manager', result["is_store_manager"]);
        prefsUser.setBool('is_agency', result["is_agency"]);
        prefsUser.setString('password', result["password"]);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ));
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          duration: const Duration(seconds: 2),
          content: const Text(
            'کد پرسنلی یا رمز عبور اشتباه است',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Vazir",
            ),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // final SharedPreferences pref = await SharedPreferences.getInstance();
      // token = pref.getString("token") ?? "";
    } else if (response.statusCode == 204) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          'کد پرسنلی یا رمز عبور اشتباه است',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Vazir",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
