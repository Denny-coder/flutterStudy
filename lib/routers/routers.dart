
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myfirstflutter/routers/router_init.dart';
import 'package:myfirstflutter/pages/list/list_router.dart';
import 'package:myfirstflutter/pages/list/page/list.dart';

class Routes {

  static String home = "/";
  static List<IRouterProvider> _listRouter = [];
  static void configureRoutes(Router router) {

    router.define(home, handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => ListPage()));

    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(ListRouter());
  
    /// 初始化路由
    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });
  }
}
