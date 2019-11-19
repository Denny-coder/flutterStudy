import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:oktoast/oktoast.dart';
import 'package:myfirstflutter/routers/application.dart';
import 'package:myfirstflutter/routers/routers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Widget home;
  MyApp({this.home}) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
          title: 'Flutter Deer',
          //showPerformanceOverlay: true, //显示性能标签
          //debugShowCheckedModeBanner: false,
          home: home,
          onGenerateRoute: Application.router.generator,
        ),
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom);
  }
}
