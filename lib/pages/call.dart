import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';
import 'package:samane_app/provider/get_tell.dart';
import 'package:url_launcher/url_launcher.dart';

class Call extends StatefulWidget {
  const Call({super.key});

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    context.read<GetTell>().fetchData;
    return Scaffold(
      body: SafeArea(
        child: Consumer<GetTell>(builder: (context, value, child) {
          return value.map.length == 0 && !value.error
              ? const Text("data")
              : value.error
                  ? Text(value.errorMessage.toString())
                  : ListView.builder(
                      itemCount: value.map.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0),
                          child: Container(
                            height: my_height * 0.06,
                            width: my_width,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          value.map[index].title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          value.map[index].phone
                                              .toString()
                                              .toPersianDigit(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: my_width * 0.1,
                                  child: const Icon(
                                    IconlyBold.call,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
        }),
        // child: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //   child: Column(
        //     children: [
        //       Container(
        //         height: my_height * 0.1,
        //         width: my_width,
        //         child: TextFormField(
        //           decoration: InputDecoration(
        //             enabledBorder: OutlineInputBorder(
        //               borderSide: const BorderSide(color: Colors.grey),
        //               borderRadius: BorderRadius.circular(10),
        //             ),
        //             suffixIcon: const Icon(IconlyLight.search),
        //           ),
        //         ),
        //       ),
        //       Expanded(
        //         child: Column(
        //           children: [
        //             call_widget(
        //                 "انفورماتیک", "402".toPersianDigit(), IconlyBold.call),
        //             call_widget(
        //                 "انفورماتیک", "402".toPersianDigit(), IconlyBold.call),
        //             call_widget(
        //                 "انفورماتیک", "402".toPersianDigit(), IconlyBold.call),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget call_widget(String title, String number, IconData icon) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
              Text(
                number,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // _callNumber();
                  // setState(() {
                  //   _makePhoneCall('tel:03591009898');
                  // });
                  _launchCaller();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(icon, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCaller() async {
    const url = "tel:03591009898";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _callNumber() async {
    const number = '03591009898'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
