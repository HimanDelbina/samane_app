import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:provider/provider.dart';
import '../../provider/get_agency_history.dart';

class AgencyHistoryPage extends StatefulWidget {
  const AgencyHistoryPage({super.key});

  @override
  State<AgencyHistoryPage> createState() => _AgencyHistoryPageState();
}

class _AgencyHistoryPageState extends State<AgencyHistoryPage> {
  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    context.read<GetAgencyHistory>().fetchData;
    return Consumer<GetAgencyHistory>(builder: (context, value, child) {
      return value.map.length == 0 && !value.error
          ? const Center(child: Text("داده ای وجود ندارد"))
          : value.error
              ? Text(value.errorMessage.toString())
              : ListView.builder(
                  itemCount: value.map.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      child: Container(
                        height: my_height * 0.1,
                        width: my_width,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Text("آژانس " +
                                      value.map[index].agency.title.toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(value.map[index].direction == "W"
                                      ? 'برگشت از شرکت'
                                      : 'آمدن به شرکت'),
                                  Text(value.map[index].createAt
                                      .toString()
                                      .toPersianDate()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
    });
  }
}
