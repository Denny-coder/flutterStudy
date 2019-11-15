import 'package:myfirstflutter/routers/router_handler.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './provide/counter.dart';
import './provide/login.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './pages/list/list.dart';

void main() {
  var counter = Counter();
  var login = Login();
  var providers = Providers();
  providers..provide(Provider<Counter>.value(counter));
  providers..provide(Provider<Login>.value(login));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    return Container(
      child: MaterialApp(
          title: '百姓生活+',
          debugShowCheckedModeBanner: false,
          //----------------主要代码start
          onGenerateRoute: Application.router.generator,
          //----------------主要代码end
          theme: ThemeData(
            primaryColor: Colors.white,
            platform: TargetPlatform.iOS,
          ),
          home: ListPage()),
    );
  }
}
