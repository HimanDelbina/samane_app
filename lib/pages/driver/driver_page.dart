import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:provider/provider.dart';
import 'package:samane_app/pages/driver/user_manager.dart';
import 'package:samane_app/static/user_static.dart';
import '../../provider/get_direction_driver.dart';
import '../../provider/set_list_user.dart';
import '../../static/url.dart';
import 'package:http/http.dart' as http;
import '../../static/user_driver_static.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({super.key});

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage>
    with SingleTickerProviderStateMixin {
  List user_data = [];
  int all_money_show = 0;
  TabController? tabController;
  //   get_data() async {
  //     await context.read<GetDirectionDriver>().fetchData;
  //   // while (true) {
  //   //   await Future.delayed(const Duration(seconds: 10));
  //   //   context.read<GetDirectionDriver>().fetchData;
  //   // }
  // }

  final List<Tab> topTabs = <Tab>[
    const Tab(text: "مسافران"),
    const Tab(text: "تاریخچه")
  ];
  List user_direction_id = [];
  @override
  void initState() {
    super.initState();
    all_money_show = 0;
    tabController = TabController(vsync: this, length: 2);
    for (var i = 0; i < StaticUserDriverFile.user_list.length; i++) {
      user_direction_id.add(StaticUserDriverFile.user_list[i].id);
    }
    print(user_direction_id);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  void create_direction() async {
    var body = jsonEncode({
      "driver": StaticUserFile.user_id,
      "direction": direction_R ? "W" : "R",
      "len": StaticUserDriverFile.user_list.length,
      "users": user_direction_id,
      "driver_money": 0,
      "user_money": 0,
      "all_money": 0,
      "is_active": false,
      "is_accept": false
    });
    String infourl =
        StaticUrlFile.url.toString() + '/company/add_driver_direction';
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

  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    context.read<GetDirectionDriver>().fetchData;
    SetUserList user_list = Provider.of<SetUserList>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontFamily: "Vazir"),
            tabs: topTabs,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            children: [
              widget_direction(),
              Container(
                height: my_height,
                width: my_width,
                child: Column(
                  children: [
                    Expanded(
                      child: Consumer<GetDirectionDriver>(
                        builder: (context, value, child) {
                          // all_money_show = value.show_money;
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
                                            height: my_height * 0.15,
                                            width: my_width,
                                            decoration: BoxDecoration(
                                                color: value.map[index]
                                                            .direction ==
                                                        "R"
                                                    ? Colors.red
                                                        .withOpacity(0.1)
                                                    : Colors.green
                                                        .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        value.map[index]
                                                                    .direction ==
                                                                "R"
                                                            ? const Text(
                                                                'برگشت از شرکت')
                                                            : const Text(
                                                                'آمدن به شرکت'),
                                                        Text(value
                                                            .map[index].createAt
                                                            .toString()
                                                            .toPersianDate()),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("تعداد مسافران : " +
                                                            user_data.length
                                                                .toString()
                                                                .toPersianDigit()),
                                                        Text("جمع مبلغ مسافران : " +
                                                            value.map[index]
                                                                .userMoney
                                                                .toPersianDigit()
                                                                .seRagham()),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("مبلغ راننده : " +
                                                            value.map[index]
                                                                .driverMoney
                                                                .toPersianDigit()
                                                                .seRagham()),
                                                        Text("جمع کل مبلغ : " +
                                                            value.map[index]
                                                                .allMoney
                                                                .toPersianDigit()
                                                                .seRagham()),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: ListView.builder(
                                                          itemCount:
                                                              user_data.length,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Row(
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5.0),
                                                                  child: Text(user_data[
                                                                          index]
                                                                      .firstName),
                                                                ),
                                                                Text(user_data[
                                                                        index]
                                                                    .lastName),
                                                                const Text(
                                                                    " - "),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      value.map[index].is_active
                                                          ? const Text(
                                                              "تایید شده",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            )
                                                          : const Text(
                                                              "تایید نشده",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            )
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool direction_R = false;
  bool direction_W = true;

  Widget widget_direction() {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    SetUserList user_list = Provider.of<SetUserList>(context);
    return Container(
      height: my_height,
      width: my_width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                          itemCount: StaticUserDriverFile.user_list.length,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 7.0),
                                              child: Text(StaticUserDriverFile
                                                  .user_list[index].firstName),
                                            ),
                                            Text(StaticUserDriverFile
                                                .user_list[index].lastName),
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
                              builder: (context) => const UserManager(),
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
                                    color: direction_W
                                        ? Colors.white
                                        : Colors.black,
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
                                    color: direction_R
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: direction_R
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                create_direction();
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
                    "ثبت",
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
    );
  }
}
