import 'package:flutter/material.dart';
import 'cartex_always.dart';
import 'cartex_temporary.dart';

class CartexPage extends StatefulWidget {
  const CartexPage({super.key});

  @override
  State<CartexPage> createState() => _CartexPageState();
}

class _CartexPageState extends State<CartexPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> topTabs = <Tab>[
    const Tab(text: "موقت"),
    const Tab(text: "دایم")
  ];
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
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
              CartexTemporary(),
              CartexAlways(),
            ],
          ),
        ),
      ),
    );
  }
}
