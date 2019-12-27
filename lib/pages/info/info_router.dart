import 'package:fluro/fluro.dart';
import 'package:myfirstflutter/routers/router_init.dart';
import 'page/house_info.dart';

class InfoRouter implements IRouterProvider {
  static String houseInfoPage = "/houseInfo";
  static String detailInfoPage = "/detailInfo";

  @override
  void initRouter(Router router) {
    router.define(houseInfoPage, handler: Handler(handlerFunc: (_, params) {
      String status = params['status'].first;
      String id = params['id'].first;
      print('params--------------');
      print(status);
      print(id);
      return HouseInfo(
        status: status,
        id: id,
      );
    }));
  }
}
