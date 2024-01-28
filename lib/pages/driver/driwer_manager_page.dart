import 'package:flutter/material.dart';
import 'package:samane_app/pages/driver/driver_accept_page.dart';
import 'package:samane_app/pages/driver/driver_wait_accept.dart';

import 'driver_reject_page.dart';

class DriverManagerPage extends StatefulWidget {
  const DriverManagerPage({super.key});

  @override
  State<DriverManagerPage> createState() => _DriverManagerPageState();
}

class _DriverManagerPageState extends State<DriverManagerPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  final List<Tab> topTabs = <Tab>[
    const Tab(text: "منتظر تایید"),
    const Tab(text: "تایید شده"),
    const Tab(text: "تایید نشده")
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
        body: TabBarView(controller: tabController, children: const [
          DriverWaitAccept(),
          DriverAcceptPage(),
          DriverRejectPage(),
        ]),
      ),
    );
  }
}
