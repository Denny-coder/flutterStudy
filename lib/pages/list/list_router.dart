import 'package:fluro/fluro.dart';
import 'package:myfirstflutter/routers/router_init.dart';
import 'page/list.dart';

class ListRouter implements IRouterProvider {
  static String listPage = "/list";

  @override
  void initRouter(Router router) {
    router.define(listPage,
        handler: Handler(handlerFunc: (_, params) => ListPage()));
  }
}
