import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samane_app/pages/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:samane_app/provider/get_cartex.dart';
import 'provider/get_agency.dart';
import 'provider/get_agency_data.dart';
import 'provider/get_agency_history.dart';
import 'provider/get_cartex_always.dart';
import 'provider/get_cartex_temporary.dart';
import 'provider/get_direction_data_wait.dart';
import 'provider/get_direction_driver.dart';
import 'provider/get_driver_data_accept.dart';
import 'provider/get_driver_data_reject.dart';
import 'provider/get_driver_user.dart';
import 'provider/get_tell.dart';
import 'provider/get_users.dart';
import 'provider/set_list_user.dart';
import 'provider/set_user_agency_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      saveLocale: true,
      supportedLocales: const [
        Locale('fa', 'IR'),
        // Locale('en', 'EN'),
      ],
      path: "assets/resourse",
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GetCartex>.value(value: GetCartex()),
        ChangeNotifierProvider<GetCartexTemporary>.value(value: GetCartexTemporary()),
        ChangeNotifierProvider<GetCartexAlways>.value(value: GetCartexAlways()),
        ChangeNotifierProvider<GetTell>.value(value: GetTell()),
        ChangeNotifierProvider<GetDriverUser>.value(value: GetDriverUser()),
        ChangeNotifierProvider<GetDirectionDriver>.value(
            value: GetDirectionDriver()),
        ChangeNotifierProvider<GetAllUsers>.value(value: GetAllUsers()),
        ChangeNotifierProvider<GetDirectionAcceptDriver>.value(
            value: GetDirectionAcceptDriver()),
        ChangeNotifierProvider<GetDirectionRejectDriver>.value(
            value: GetDirectionRejectDriver()),
        ChangeNotifierProvider<GetDirectionWaitDriver>.value(
            value: GetDirectionWaitDriver()),
        ChangeNotifierProvider<SetUserList>.value(value: SetUserList()),
        ChangeNotifierProvider<SetUserAgencyList>.value(value: SetUserAgencyList()),
        ChangeNotifierProvider<GetAgencyData>.value(value: GetAgencyData()),
        ChangeNotifierProvider<GetAgency>.value(value: GetAgency()),
        ChangeNotifierProvider<GetAgencyHistory>.value(value: GetAgencyHistory()),
      ],
      child: MaterialApp(
        // scaffoldMessengerKey: _messangerKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',

        theme: ThemeData(
          fontFamily: "Vazir",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
