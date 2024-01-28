import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:samane_app/pages/driver/driver_page.dart';
import 'package:samane_app/provider/get_users.dart';
import '../../provider/set_list_user.dart';
import '../../static/user_driver_static.dart';

class UserManager extends StatefulWidget {
  const UserManager({super.key});

  @override
  State<UserManager> createState() => _UserManagerState();
}

class _UserManagerState extends State<UserManager> {
  bool user_is_here = true;
  @override
  Widget build(BuildContext context) {
    double my_height = MediaQuery.of(context).size.height;
    double my_width = MediaQuery.of(context).size.width;
    context.read<GetAllUsers>().fetchData;
    SetUserList user_list = Provider.of<SetUserList>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const DriverPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Icon(IconlyLight.arrow_left_2))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 7.0),
                                          child: Text(StaticUserDriverFile
                                              .user_list[index].firstName),
                                        ),
                                        Text(StaticUserDriverFile
                                            .user_list[index].lastName),
                                      ],
                                    ),
                                    const Icon(Icons.remove, color: Colors.red)
                                  ],
                                ),
                              ))),
                        );
                      },
                    ),
                  )),
              TextFormField(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Consumer<GetAllUsers>(
                    builder: (context, value, child) {
                      return value.map.length == 0 && !value.error
                          ? const Text("data")
                          : value.error
                              ? Text(value.errorMessage.toString())
                              : ListView.builder(
                                  itemCount: value.map.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          user_is_here = true;
                                        });
                                        if (StaticUserDriverFile
                                                .user_list.length ==
                                            0) {
                                          user_list.addItem(value.map[index]);
                                          print(user_list);
                                          // user_list.addItem(StaticUserDriverFile
                                          //     .user_list[index]);
                                          // setState(() {
                                          //   StaticUserDriverFile.user_list
                                          //       .add(value.map[index]);
                                          // });
                                        } else {
                                          for (var i = 0;
                                              i <
                                                  StaticUserDriverFile
                                                      .user_list.length;
                                              i++) {
                                            if (value.map[index].id ==
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
                                                duration:
                                                    const Duration(seconds: 2),
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
                                            user_list.addItem(value.map[index]);
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
                                                    child: Text(value
                                                        .map[index].firstName),
                                                  ),
                                                  Text(value
                                                      .map[index].lastName),
                                                ],
                                              ),
                                            ),
                                            const Icon(Icons.add,
                                                size: 20.0, color: Colors.blue)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>const DriverPage(),));
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
                      "تاببد",
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
      ),
    );
  }
}
