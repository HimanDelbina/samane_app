import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:samane_app/model/users_model.dart';
import 'package:samane_app/pages/agency/user_manager_agency.dart';
import 'package:samane_app/provider/get_users.dart';
import 'package:samane_app/provider/set_list_user.dart';
import 'package:samane_app/provider/set_user_agency_list.dart';
import '../../components/search_component.dart';
import '../../model/agency_model.dart';
import 'package:http/http.dart' as http;

import '../../static/url.dart';
import '../../static/user_driver_static.dart';

class AgencyAcceptPage extends StatefulWidget {
  const AgencyAcceptPage({super.key});

  @override
  State<AgencyAcceptPage> createState() => _AgencyAcceptPageState();
}

class _AgencyAcceptPageState extends State<AgencyAcceptPage> {
  bool user_is_here = true;
  var show_data = [];
  var show_data_Search = [];
  TextEditingController user_search_controller = TextEditingController();
  List user_direction_id = [];
  final listenercontroller = ScrollController();
  void onListenerController() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    get_agency();
    listenercontroller.addListener(onListenerController);
    for (var i = 0; i < StaticUserDriverFile.user_list_agency.length; i++) {
      user_direction_id.add(StaticUserDriverFile.user_list_agency[i].id);
    }
    print(user_direction_id);
    // get_users();
  }

  @override
  void dispose() {
    listenercontroller.removeListener(onListenerController);
    super.dispose();
  }

  bool direction_R = false;
  bool direction_W = true;

  int? select_agency;
  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    context.read<GetAllUsers>().fetchData;
    SetUserAgencyList user_list = Provider.of<SetUserAgencyList>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            is_get == false
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    width: my_width,
                    height: my_height * 0.3,
                    // color: Colors.amber,
                    child: ListView.builder(
                      itemCount: data_list!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              data_list![index].title,
                              style: TextStyle(
                                  fontWeight: data_bool[index]
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                            tileColor: Colors.grey.withOpacity(0.1),
                            trailing: Icon(IconlyLight.tick_square,
                                color: data_bool[index]
                                    ? Colors.blue
                                    : Colors.grey),
                            selectedColor: Colors.black,
                            selected: data_bool[index],
                            selectedTileColor: data_bool[index]
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.grey,
                            onTap: () {
                              setState(() {
                                data_bool = [];
                                data_bool =
                                    data_list!.map<bool>((v) => false).toList();
                                data_bool[index] = true;
                                select_agency = data_list![index].id;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        direction_R = false;
                        direction_W = true;
                      });
                    },
                    child: Container(
                      height: my_height * 0.06,
                      width: my_width * 0.42,
                      decoration: BoxDecoration(
                        color: direction_W
                            ? Colors.blue
                            : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          'آمدن به شرکت',
                          style: TextStyle(
                              color: direction_W ? Colors.white : Colors.black,
                              fontWeight: direction_W
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        direction_R = true;
                        direction_W = false;
                      });
                    },
                    child: Container(
                      height: my_height * 0.06,
                      width: my_width * 0.42,
                      decoration: BoxDecoration(
                        color: direction_R
                            ? Colors.blue
                            : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          'برگشت از شرکت',
                          style: TextStyle(
                              color: direction_R ? Colors.white : Colors.black,
                              fontWeight: direction_R
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            //   child: TextFormField(
            //     keyboardType: TextInputType.text,
            //     controller: user_search_controller,
            //     // cursorColor: theme.cursorSearch,
            //     decoration: const InputDecoration(
            //         labelText: "serach",
            //         hintText: "serach",
            //         // hintStyle: TextStyle(color: theme.unselectItem),
            //         // labelStyle: TextStyle(color: theme.text),
            //         // suffixIconColor: theme.iconItem,
            //         // suffixIcon: Icon(IconlyLight.search, color: theme.iconItem),
            //         focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.blue)),
            //         enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.blue)),
            //         border: OutlineInputBorder()),
            //     onChanged: (value) {
            //       setState(() {
            //         setState(() {
            //           show_data = Search.search(show_data_Search, value,
            //               "firstName_lastName_companyCode");
            //         });
            //       });
            //     },
            //   ),
            // ),
            Container(
                height: my_height * 0.15,
                width: my_width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: StaticUserDriverFile.user_list_agency.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          user_list.removeItem(
                              StaticUserDriverFile.user_list[index]);
                          // setState(() {
                          //   StaticUserDriverFile.user_list.remove(
                          //       StaticUserDriverFile.user_list[index]);
                          // });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 7.0),
                                        child: Text(StaticUserDriverFile
                                            .user_list_agency[index].firstName),
                                      ),
                                      Text(StaticUserDriverFile
                                          .user_list_agency[index].lastName),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ))),
                      );
                    },
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserManagerAgency(),
                      ));
                },
                child: Container(
                  height: my_height * 0.06,
                  width: my_width,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Center(
                    child: Text(
                      "مدیریت مسافران",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 10.0),
            //     child: Consumer<GetAllUsers>(
            //       builder: (context, value, child) {
            //         user_search_controller.text == ""
            //             ? show_data = value.map
            //             : show_data = show_data;
            //         show_data_Search = value.map;
            //         return value.map.length == 0 && !value.error
            //             ? const Text("data")
            //             : value.error
            //                 ? Text(value.errorMessage.toString())
            //                 : show_data.length != 0
            //                     ? ListView.builder(
            //                         controller: listenercontroller,
            //                         itemCount: show_data.length,
            //                         itemBuilder: (context, index) {
            //                           return GestureDetector(
            //                             onTap: () {
            //                               setState(() {
            //                                 user_is_here = true;
            //                               });
            //                               if (StaticUserDriverFile
            //                                       .user_list_agency.length ==
            //                                   0) {
            //                                 user_list.addItem(show_data[index]);
            //                               } else {
            //                                 for (var i = 0;
            //                                     i <
            //                                         StaticUserDriverFile
            //                                             .user_list_agency.length;
            //                                     i++) {
            //                                   if (show_data[index].id ==
            //                                       StaticUserDriverFile
            //                                           .user_list_agency[i].id) {
            //                                     setState(() {
            //                                       user_is_here = false;
            //                                     });
            //                                     final snackBar = SnackBar(
            //                                       behavior:
            //                                           SnackBarBehavior.floating,
            //                                       shape: RoundedRectangleBorder(
            //                                           borderRadius:
            //                                               BorderRadius.circular(
            //                                                   10.0)),
            //                                       duration:
            //                                           const Duration(seconds: 2),
            //                                       content: const Text(
            //                                         'کاربر قبلا اضافه شده ',
            //                                         textAlign: TextAlign.center,
            //                                         style: TextStyle(
            //                                             fontFamily: "Vazir"),
            //                                       ),
            //                                     );
            //                                     ScaffoldMessenger.of(context)
            //                                         .showSnackBar(snackBar);
            //                                     break;
            //                                   }
            //                                 }
            //                                 if (user_is_here) {
            //                                   user_list.addItem(show_data[index]);
            //                                   // setState(() {
            //                                   //   StaticUserDriverFile.user_list
            //                                   //       .add(value.map[index]);
            //                                   // });
            //                                 }
            //                               }
            //                             },
            //                             child: Container(
            //                               padding: const EdgeInsets.symmetric(
            //                                   horizontal: 15.0, vertical: 5.0),
            //                               margin: const EdgeInsets.all(3.0),
            //                               decoration: BoxDecoration(
            //                                 color: Colors.grey.withOpacity(0.1),
            //                                 borderRadius:
            //                                     BorderRadius.circular(5.0),
            //                               ),
            //                               child: Row(
            //                                 children: [
            //                                   Expanded(
            //                                     child: Row(
            //                                       children: [
            //                                         Padding(
            //                                           padding:
            //                                               const EdgeInsets.only(
            //                                                   left: 7.0),
            //                                           child: Text(show_data[index]
            //                                               .firstName),
            //                                         ),
            //                                         Text(show_data[index].lastName),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                   const Icon(Icons.add,
            //                                       size: 20.0, color: Colors.blue)
            //                                 ],
            //                               ),
            //                             ),
            //                           );
            //                         },
            //                       )
            //                     : const Center(
            //                         child: Text("data"),
            //                       );
            //       },
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                create_agency();
              },
              child: Container(
                height: my_height * 0.1,
                width: my_width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Text(
                    "ثبت",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool is_get = false;
  List<bool> data_bool = [];
  List? data_list;
  List? agency;
  Future<List<AgencyModel>?> get_agency() async {
    var response = await http.get(
        Uri.parse(StaticUrlFile.url.toString() + "/agency/get_agency_all"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });
    if (response.statusCode == 200) {
      var x = json.decode(response.body);
      agency = x.map((e) => AgencyModel.fromJson(e)).toList();
      // var x = json.decode(response.body);
      // var listdata = agencyModelFromJson(x);
      setState(() {
        data_list = agency;
        data_bool = data_list!.map<bool>((v) => false).toList();
        data_bool[0] = true;
        select_agency = 1;
        is_get = true;
      });
    }
  }

  void create_agency() async {
    var body = jsonEncode({
      "agency": select_agency,
      "users": user_direction_id,
      "direction": direction_R ? "W" : "R",
    });
    String infourl = StaticUrlFile.url.toString() + '/agency/create_agencyuser';
    var response = await http.post(Uri.parse(infourl), body: body, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "با موفقیت ثبت شد",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Vazir"),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

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

  // bool is_get_users = false;
  // // List<bool> data_bool = [];
  // List? data_list_users;
  // List? data_list_users_search;
  // List? users;
  // Future<List<UsersModel>?> get_users() async {
  //   var response = await http.get(
  //       Uri.parse(StaticUrlFile.url.toString() + "/company/get_all_user"),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //       });
  //   if (response.statusCode == 200) {
  //     var x = json.decode(response.body);
  //     users = x.map((e) => UsersModel.fromJson(e)).toList();
  //     // var x = json.decode(response.body);
  //     // var listdata = agencyModelFromJson(x);
  //     setState(() {
  //       data_list_users = users;
  //       data_list_users_search = data_list_users;
  //       // data_bool = data_list!.map<bool>((v) => false).toList();
  //       // data_bool[0] = true;
  //       is_get_users = true;
  //     });
  //   }
  // }
}
