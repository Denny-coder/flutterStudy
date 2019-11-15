import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:dio/dio.dart';
import '../../provide/login.dart';
import 'package:myfirstflutter/widgets/app_bar.dart';
import '../../routers/application.dart';
import 'package:fluro/fluro.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController _controllerAccount = new TextEditingController();
  TextEditingController _controllerPassWord = new TextEditingController();
  String _account;
  String _passWord;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          centerTitle: '资产处置',
          // backgroundColor:Colors.blue,
          isBack:false
        ),
        body: SingleChildScrollView());
  }
}
