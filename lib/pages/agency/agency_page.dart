import 'package:flutter/material.dart';
import 'package:samane_app/pages/agency/agency_accept_page.dart';
import 'package:samane_app/pages/agency/agency_history_page.dart';

class AgencyPage extends StatefulWidget {
  const AgencyPage({super.key});

  @override
  State<AgencyPage> createState() => _AgencyPageState();
}

class _AgencyPageState extends State<AgencyPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> topTabs = <Tab>[
    const Tab(text: "ثبت"),
    const Tab(text: "تاریخچه")
  ];
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
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
            children: const [
              AgencyAcceptPage(),
              AgencyHistoryPage(),
            ],
          ),
        ),
      ),
    );
  }
}
