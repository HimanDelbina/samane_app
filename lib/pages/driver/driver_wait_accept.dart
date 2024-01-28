import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:provider/provider.dart';

import '../../provider/get_direction_data_wait.dart';
import '../../static/url.dart';
import 'package:http/http.dart' as http;

class DriverWaitAccept extends StatefulWidget {
  const DriverWaitAccept({super.key});

  @override
  State<DriverWaitAccept> createState() => _DriverWaitAcceptState();
}

class _DriverWaitAcceptState extends State<DriverWaitAccept> {
  List user_data = [];
  int? id_select;
  bool is_active = false;
  bool is_accept = false;
  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    context.read<GetDirectionWaitDriver>().fetchData;
    return Consumer<GetDirectionWaitDriver>(
      builder: (context, value, child) {
        return value.map.length == 0 && !value.error
            ? const Center(child: Text("داده ای وجود ندارد"))
            : value.error
                ? Text(value.errorMessage.toString())
                : ListView.builder(
                    itemCount: value.map.length,
                    itemBuilder: (context, index) {
                      user_data = value.map[index].users;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        child: Container(
                          width: my_width,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            value.map[index].driver.firstName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          value.map[index].driver.lastName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              is_accept = true;
                                              is_active = true;
                                              id_select = value.map[index].id;
                                            });
                                            edit_direction();
                                          },
                                          child: Container(
                                            width: my_width * 0.2,
                                            decoration: BoxDecoration(
                                                color: Colors.amber
                                                    .withOpacity(0.5)),
                                            child: const Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                child: Text("منتظر تایید"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              is_accept = false;
                                              is_active = true;
                                              id_select = value.map[index].id;
                                            });
                                            edit_direction();
                                          },
                                          child: Container(
                                            width: my_width * 0.2,
                                            decoration: BoxDecoration(
                                                color: Colors.red
                                                    .withOpacity(0.5)),
                                            child: const Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0),
                                                child: Text("منتظر رد"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: my_height * 0.06,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: user_data.length,
                                          itemBuilder: (context, index) => Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                    user_data[index].firstName),
                                              ),
                                              Text(user_data[index].lastName),
                                              const Text(" - ")
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        value.map[index].createAt
                                            .toString()
                                            .toPersianDate(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
      },
    );
  }

  void edit_direction() async {
    var body = jsonEncode(
        {"id": id_select, "is_active": is_active, "is_accept": is_accept});
    String infourl =
        StaticUrlFile.url.toString() + '/company/edit_direction_data';
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
          "با موفقیت تایید شد",
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
