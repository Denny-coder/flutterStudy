import 'dart:convert' as JSON;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myfirstflutter/widgets/app_bar.dart';
import 'package:myfirstflutter/widgets/my_refresh_list.dart';
import '../widget/product_item.dart';
import '../models/product.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  List<ProductList> _tableData = new List<ProductList>();
  int _total;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    // 动画曲线
    CurvedAnimation _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _animation = new Tween(begin: 0.0, end: 1.1).animate(_curvedAnimation);
    _refresh();
  }


  Future<Null> _refresh() async {
    List<ProductList> productDataList = new List();
    print('_refresh');
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
        "https://test.aiwoke.com.cn/houseinfoController/getListPage?token=crm:wecat:token0000Fu&type=1",
        data: {
          "showStatus": 1,
          "rows": 10,
          "page": 1,
          "houseName": "",
          "type": ""
        },
        options: Options(
          headers: {
            'token': 'crm:wecat:token0000Fu',
            'content-type': 'application/json'
          },
        ),
      );
      var data = JSON.jsonDecode(response.toString());
      print(data);

      if (data['success']) {
        for (dynamic data in data['data']['list']) {
          ProductList productData = ProductList.fromJson(data);
          productDataList.add(productData);
        }
        print('----------response---------------');
        print(productDataList);
        print('----------response---------------');
        setState(() {
          _total = data['data']['total'];
          _tableData = productDataList;
        });
      }
    } catch (e) {
      return print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
            centerTitle: '资产处置',
            // backgroundColor:Colors.blue,
            isBack: false),
        body: DeerListView(
            itemCount: _tableData.length,
            onRefresh: _refresh,
            total: _total,
            loadMore: _refresh,
            itemBuilder: (_, index) {
              return ProductItem(
                index: index,
                data: _tableData[index],
                selectIndex: 0,
                onTapMenu: () {},
                onTapEdit: () {},
                onTapOperation: () {},
                onTapDelete: () {},
                onTapMenuClose: () {},
                animation: _animation,
              );
            }));
  }
}
