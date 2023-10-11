import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:item_1/page/app.dart';

void main() {
  runApp(const MyApp());
  // 状态栏沉浸
  // bug 在夜间模式时，状态栏颜色强制更改
  SystemUiOverlayStyle style = const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  );
    SystemChrome.setSystemUIOverlayStyle(style);

  /// 路由
  // final router = FluroRouter();
  // Routes.configureRoutes(router);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      defaultTransition: Transition.size,
      transitionDuration: const Duration(milliseconds: 300),
      home: app(),
    );
  }
}
