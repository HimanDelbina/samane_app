import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:provider/provider.dart';
import '../../provider/get_cartex_always.dart';
import '../../static/url.dart';

class CartexAlways extends StatefulWidget {
  const CartexAlways({super.key});

  @override
  State<CartexAlways> createState() => _CartexAlwaysState();
}

class _CartexAlwaysState extends State<CartexAlways> {
  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    context.read<GetCartexAlways>().fetchData;
    return Consumer<GetCartexAlways>(builder: (context, value, child) {
      return value.map.length == 0 && !value.error
          ? const Center(
              child: Text("شما هیچ وسیله ای از انبار تحویل نگرفته اید"))
          : value.error
              ? Text(value.errorMessage.toString())
              : ListView.builder(
                  itemCount: value.map.length,
                  itemBuilder: (context, index) {
                    return value.map[index].is_always == true
                        ? show_widget(
                            value.map[index].title,
                            value.map[index].createAt.toString(),
                            value.map[index].is_back,
                            () {
                              if (value.map[index].is_back == true) {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  duration: const Duration(seconds: 2),
                                  content: const Text(
                                    "منتظر تایید انبار",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: "Vazir"),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                setState(() {
                                  id_select = value.map[index].id;
                                  is_back = true;
                                });
                                cartex_back();
                              }
                            },
                            () {
                              if (value.map[index].is_back) {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  duration: const Duration(seconds: 2),
                                  content: const Text(
                                    "منتظر تایید انبار",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: "Vazir"),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  duration: const Duration(seconds: 2),
                                  content: const Text(
                                    "لطفا روی ایکون کلیک کنبد",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: "Vazir"),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          )
                        : const Center(
                            child: Text(
                                "شما هیچ وسیله ای از انبار تحویل نگرفته اید"));
                  },
                );
    });
  }

  Widget show_widget(String title, String date, bool is_back,
      VoidCallback ontab_icon, VoidCallback ontab_container) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: GestureDetector(
        onTap: ontab_container,
        child: Container(
          decoration: BoxDecoration(
            color: is_back
                ? Colors.red.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: ontab_icon,
                      child: const Icon(
                        IconlyLight.edit_square,
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(title),
                    ),
                  ],
                ),
                Text(date.toPersianDate()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int? id_select;
  bool? is_back;
  void cartex_back() async {
    var body = jsonEncode({"id": id_select, "is_back": is_back});
    String infourl = StaticUrlFile.url.toString() + '/cartex/cartex_user_back';
    var response = await http.post(Uri.parse(infourl), body: body, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "با موفقیت برگشت داده شد",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Vazir"),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {});
      // final SharedPreferences pref = await SharedPreferences.getInstance();
      // token = pref.getString("token") ?? "";
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "خطایی رخ داده",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Vazir"),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
