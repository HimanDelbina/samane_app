import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:samane_app/pages/agency/agency_page.dart';
import 'package:samane_app/pages/call.dart';
import 'package:samane_app/pages/cartex/cartex.dart';
import 'package:samane_app/pages/driver/driver_page.dart';
import 'package:samane_app/pages/pm/pm.dart';
import 'package:samane_app/pages/store/store_manager.dart';
import 'package:samane_app/test_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'driver/driwer_manager_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    get_static_user_data();
  }

  bool loading = false;

  int? id;
  String? token;
  String? first_name;
  String? last_name;
  String? company_code;
  String? post;
  bool? is_driver;
  bool? is_admin;
  bool? is_tell;
  bool? is_driver_role;
  bool? is_scan;
  bool? is_pm;
  bool? is_cartex;
  bool? is_store_manager;
  bool? is_agency;

  void get_static_user_data() async {
    final SharedPreferences prefsUser = await SharedPreferences.getInstance();

    id = prefsUser.getInt("id");
    token = prefsUser.getString("token");
    first_name = prefsUser.getString("first_name");
    last_name = prefsUser.getString("last_name");
    company_code = prefsUser.getString("company_code");
    post = prefsUser.getString("post");
    is_driver = prefsUser.getBool("is_driver");
    is_admin = prefsUser.getBool("is_admin");
    is_tell = prefsUser.getBool("is_tell");
    is_driver_role = prefsUser.getBool("is_driver_role");
    is_scan = prefsUser.getBool("is_scan");
    is_pm = prefsUser.getBool("is_pm");
    is_cartex = prefsUser.getBool("is_cartex");
    is_store_manager = prefsUser.getBool("is_store_manager");
    is_agency = prefsUser.getBool("is_agency");
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: loading
              ? Column(
                  children: [
                    is_cartex!
                        ? home_wisget("کارتکس انبار", IconlyLight.paper, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartexPage(),
                                ));
                          })
                        : const SizedBox(),
                    is_driver!
                        ? home_wisget("راننده", IconlyLight.user, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DriverPage(),
                                ));
                          })
                        : const SizedBox(),
                    is_driver_role!
                        ? home_wisget("مدیریت راننده ها", IconlyLight.user, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DriverManagerPage(),
                                ));
                          })
                        : const SizedBox(),
                    is_tell!
                        ? home_wisget("شماره تلفن", IconlyLight.calling, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Call(),
                              ),
                            );
                          })
                        : const SizedBox(),
                    is_pm!
                        ? home_wisget("پی ام", IconlyLight.setting, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PmPage(),
                              ),
                            );
                          })
                        : const SizedBox(),
                    is_store_manager!
                        ? home_wisget("مدیریت انبار", IconlyLight.home, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StoreManagerPage(),
                              ),
                            );
                          })
                        : const SizedBox(),
                    is_agency!
                        ? home_wisget("مدیریت آژانس", IconlyLight.ticket, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AgencyPage(),
                              ),
                            );
                          })
                        : const SizedBox(),
                    // home_wisget("test page", IconlyLight.ticket, () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const TestPage(),
                    //       ),
                    //     );
                    //   })
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget home_wisget(String title, IconData icon, VoidCallback ontap) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: my_height * 0.07,
          width: my_width,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(icon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
