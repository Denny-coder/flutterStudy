import 'package:fluro/fluro.dart';
import 'package:myfirstflutter/routers/router_init.dart';
import 'page/detail_info.dart';

class InfoRouter implements IRouterProvider {
  static String houseInfoPage = "/houseInfo";
  static String detailInfoPage = "/detailInfo";

  @override
  void initRouter(Router router) {
    router.define(detailInfoPage,
        handler: Handler(handlerFunc: (_, params) => DetailInfo()));
  }
}
