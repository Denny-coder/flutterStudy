import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:dio/dio.dart';
import '../../provide/login.dart';
import 'package:myfirstflutter/widgets/app_bar.dart';
import '../../routers/application.dart';
import './widget/product_item.dart';
import 'package:fluro/fluro.dart';
import 'dart:convert' as JSON;
import 'package:myfirstflutter/widgets/my_refresh_list.dart';
import '../data/product.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  TextEditingController _controllerAccount = new TextEditingController();
  TextEditingController _controllerPassWord = new TextEditingController();
  List<ProductList> _tableData = new List<ProductList>();
  String _account;
  String _passWord;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controllerAccount.addListener(() {
      setState(() {
        _account = _controllerAccount.value.text;
      });
    });
    _controllerPassWord.addListener(() {
      setState(() {
        _passWord = _controllerPassWord.value.text;
      });
    });
    setState(() {
      _controllerAccount.value =
          _controllerAccount.value.copyWith(text: 'admin');
      _controllerPassWord.value =
          _controllerAccount.value.copyWith(text: 'zx123456');
      _account = 'admin';
      _passWord = 'zx123456';
    });
    // 初始化动画控制
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    // 动画曲线
    CurvedAnimation _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _animation = new Tween(begin: 0.0, end: 1.1).animate(_curvedAnimation);
    _refresh();
  }

  void login() async {
    print(_account);
    print(_passWord);
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.get("http://student.bestzhengke.com/api/user/login",
          queryParameters: {'account': _account, 'pwd': _passWord});
      print(response.data['code']);
      if (response.data['code'] == 200) {
        print(response.data['data']['token']);
        print(response.data['data']['l_id']);
        Provide.value<Login>(context)
            .incrementToken(response.data['data']['token']);
        Provide.value<Login>(context).incrementCookie(
            'L_ID=${response.data['data']['token']}; Admin-Token=${response.data['data']['token']}');
        Application.router.navigateTo(context, "/cart?id=cart",
            transition: TransitionType.fadeIn);
      }
    } catch (e) {
      return print(e);
    }
  }

  Future<Null> _refresh() async {
    List<ProductList> productDataList = new List();
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

      if (data['success']) {
        for (dynamic data in data['data']['list']) {
          ProductList productData = ProductList.fromJson(data);
          productDataList.add(productData);
        }
        print('----------response---------------');
        print(productDataList);
        print('----------response---------------');
        setState(() {
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
