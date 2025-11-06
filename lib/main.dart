import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:user_hub/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        splitScreenMode: true,
      minTextAdapt: true,
      builder: (BuildContext context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "User Info",
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
          scaffoldBackgroundColor: Colors.white,
          cardColor: Colors.white
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.red,
            scaffoldBackgroundColor: Colors.black,
            cardColor: Colors.black54
        ),
        themeMode: ThemeMode.light,
        home: MyHomePage(),
      ),
    );
  }
}


