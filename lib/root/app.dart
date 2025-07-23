import 'package:flutter/material.dart';
import 'package:template/common/enums/flavors.dart';
import 'package:template/root/app_routers.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      onGenerateRoute: AppRouters.onGenRoutes,
      initialRoute: AppRouters.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
