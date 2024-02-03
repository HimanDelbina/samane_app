import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samane_app/components/search_component.dart';
import 'package:samane_app/provider/get_users.dart';
import 'package:samane_app/provider/set_list_user.dart';
import 'package:samane_app/static/user_driver_static.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
    SetUserList user_list = Provider.of<SetUserList>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                    show_data = Search.search(show_data_Search, value,
                        "firstName_lastName_companyCode");
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
                                                  .user_list.length ==
                                              0) {
                                            user_list.addItem(show_data[index]);
                                          } else {
                                            for (var i = 0;
                                                i <
                                                    StaticUserDriverFile
                                                        .user_list.length;
                                                i++) {
                                              if (show_data[index].id ==
                                                  StaticUserDriverFile
                                                      .user_list[i].id) {
                                                setState(() {
                                                  user_is_here = false;
                                                });
                                                final snackBar = SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  content: const Text(
                                                    'کاربر قبلا اضافه شده ',
                                                    textAlign: TextAlign.center,
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
                                              user_list
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
                                              horizontal: 15.0, vertical: 5.0),
                                          margin: const EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
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
                                                          const EdgeInsets.only(
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
            )
          ],
        ),
      ),
    );
  }
}
