import 'package:flutter/material.dart';

class StoreManagerPage extends StatefulWidget {
  const StoreManagerPage({super.key});

  @override
  State<StoreManagerPage> createState() => _StoreManagerPageState();
}

class _StoreManagerPageState extends State<StoreManagerPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> topTabs = <Tab>[
    const Tab(text: "درخواست ها"),
    const Tab(text: "کارتکس"),
    const Tab(text: "کاربران"),
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
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            children: const [],
          ),
        ),
      ),
    );
  }
}
