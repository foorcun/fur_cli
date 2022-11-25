import 'package:auth/auth.dart';
import 'package:dizi_ayraci_v7/features/dizi/presentation/state_management/all_dizi_bindings.dart';
import 'package:dizi_ayraci_v7/features/dizi/presentation/state_management/bindings/dizi_list_page_binding.dart';
import 'package:dizi_ayraci_v7/features/main_presentation/dizi_add_page.dart';
import 'package:dizi_ayraci_v7/features/main_presentation/dizi_list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'injection_container.dart' as di;

//start the server
//start C:\API
//json-server --watch dizi_ayraci_inner.json

// flutter run -d chrome --web-hostname localhost --web-port 5000 --no-sound-null-safety

// flutter run -d chrome --web-hostname localhost --web-port 5000 --no-sound-null-safety
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await di.init();
  AllDiziBindings().dependencies();
  AllAuthInit().dependencies(); // Auth initialize etmeyi unutma
  // MainPresentationHelper.homePage = DiziListPage();
  // final UserController uC = Get.put(UserController()); //

  // runApp(const PlainDiziler());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return GetBuilder<UserController>(
    //   builder: ((_) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dizi ayraci v7',
      // home: const DiziListPage(),
      // initialRoute: "/DiziListPage",
      initialRoute: "/home",
      getPages: [
        GetPage(
            name: "/DiziListPage",
            page: () => DiziListPage(),
            binding: DiziListPageBinding()),
        GetPage(name: "/DiziAddPage", page: () => DiziAddPage()),
        // GetPage(
        //     name: "/PlainSignIn",
        //     page: () => MainPresentationHelper.getPlainSignIn()),
        GetPage(
            name: "/home", page: () => MainPresentationHelper.getHomeView()),
        GetPage(
            name: "/login",
            page: () => MainPresentationHelper.getLogin(),
            binding: LoginBinding()),
        GetPage(
          name: "/welcome",
          page: () => MainPresentationHelper.getWelcome(),
          binding: WelcomeBinding(),
        ),
      ],
    );
    // }),
    // );
  }
}