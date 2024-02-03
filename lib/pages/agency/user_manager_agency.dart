import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:samane_app/pages/agency/agency_accept_page.dart';
import 'package:samane_app/pages/agency/agency_page.dart';
import 'package:samane_app/pages/driver/driver_page.dart';
import 'package:samane_app/provider/get_users.dart';
import 'package:samane_app/provider/set_user_agency_list.dart';
import '../../components/search_component.dart';
import '../../provider/set_list_user.dart';
import '../../static/user_driver_static.dart';

class UserManagerAgency extends StatefulWidget {
  const UserManagerAgency({super.key});

  @override
  State<UserManagerAgency> createState() => _UserManagerState();
}

class _UserManagerState extends State<UserManagerAgency> {
  bool user_is_here = true;
  var show_data = [];
  var show_data_Search = [];
  TextEditingController user_search_controller = TextEditingController();

  final listenercontroller = ScrollController();
  void onListenerController() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    listenercontroller.addListener(onListenerController);
  }

  @override
  void dispose() {
    listenercontroller.removeListener(onListenerController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    context.read<GetAllUsers>().fetchData;
    SetUserAgencyList user_list_agency =
        Provider.of<SetUserAgencyList>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const DriverPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Icon(IconlyLight.arrow_left_2))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            children: [
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
                            user_list_agency.removeItem(
                                StaticUserDriverFile.user_list_agency[index]);
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
                                              .user_list_agency[index]
                                              .firstName),
                                        ),
                                        Text(StaticUserDriverFile
                                            .user_list_agency[index].lastName),
                                      ],
                                    ),
                                    const Icon(Icons.remove, color: Colors.red)
                                  ],
                                ),
                              ))),
                        );
                      },
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: user_search_controller,
                  // cursorColor: theme.cursorSearch,
                  decoration: const InputDecoration(
                      labelText: "serach",
                      hintText: "serach",
                      // hintStyle: TextStyle(color: theme.unselectItem),
                      // labelStyle: TextStyle(color: theme.text),
                      // suffixIconColor: theme.iconItem,
                      // suffixIcon: Icon(IconlyLight.search, color: theme.iconItem),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      border: OutlineInputBorder()),
                  onChanged: (value) {
                    setState(() {
                      setState(() {
                        show_data = Search.search(show_data_Search, value,
                            "firstName_lastName_companyCode");
                      });
                    });
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Consumer<GetAllUsers>(
                    builder: (context, value, child) {
                      user_search_controller.text == ""
                          ? show_data = value.map
                          : show_data = show_data;
                      show_data_Search = value.map;
                      return value.map.length == 0 && !value.error
                          ? const Text("data")
                          : value.error
                              ? Text(value.errorMessage.toString())
                              : show_data.length != 0
                                  ? ListView.builder(
                                      controller: listenercontroller,
                                      itemCount: show_data.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              user_is_here = true;
                                            });
                                            if (StaticUserDriverFile
                                                    .user_list_agency.length ==
                                                0) {
                                              user_list_agency
                                                  .addItem(show_data[index]);
                                            } else {
                                              for (var i = 0;
                                                  i <
                                                      StaticUserDriverFile
                                                          .user_list_agency
                                                          .length;
                                                  i++) {
                                                if (show_data[index].id ==
                                                    StaticUserDriverFile
                                                        .user_list_agency[i]
                                                        .id) {
                                                  setState(() {
                                                    user_is_here = false;
                                                  });
                                                  final snackBar = SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    content: const Text(
                                                      'کاربر قبلا اضافه شده ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Vazir"),
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                  break;
                                                }
                                              }
                                              if (user_is_here) {
                                                user_list_agency
                                                    .addItem(show_data[index]);
                                                // setState(() {
                                                //   StaticUserDriverFile.user_list
                                                //       .add(value.map[index]);
                                                // });
                                              }
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 5.0),
                                            margin: const EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 7.0),
                                                        child: Text(
                                                            show_data[index]
                                                                .firstName),
                                                      ),
                                                      Text(show_data[index]
                                                          .lastName),
                                                    ],
                                                  ),
                                                ),
                                                const Icon(Icons.add,
                                                    size: 20.0,
                                                    color: Colors.blue)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: Text("data"),
                                    );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AgencyPage(),
                      ));
                },
                child: Container(
                  height: my_height * 0.06,
                  width: my_width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Center(
                    child: Text(
                      "تاببد",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
