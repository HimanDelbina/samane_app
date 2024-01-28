import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:provider/provider.dart';
import '../../provider/get_driver_data_accept.dart';

class DriverAcceptPage extends StatefulWidget {
  const DriverAcceptPage({super.key});

  @override
  State<DriverAcceptPage> createState() => _DriverAcceptPageState();
}

class _DriverAcceptPageState extends State<DriverAcceptPage> {
  List user_data = [];
  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    context.read<GetDirectionAcceptDriver>().fetchData;
    return Consumer<GetDirectionAcceptDriver>(
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
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: my_width * 0.2,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.green.withOpacity(0.5)),
                                        child: const Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Text("تایید شده"),
                                          ),
                                        ),
                                      ),
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
}
