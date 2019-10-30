// import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
// import '../../routers/application.dart';
import 'package:dio/dio.dart';
import '../../provide/login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        // Application.router.navigateTo(context, "/cart?id=cart",
        //     transition: TransitionType.fadeIn,
        //     transitionDuration: Duration(milliseconds: 3000));
      }
    } catch (e) {
      return print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('登录'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 150),
          child: Column(
            children: <Widget>[
              Provide<Login>(
                builder: (context, child, counter) {
                  return Text(
                    '${Login.token}',
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              ),
              Provide<Login>(
                builder: (context, child, counter) {
                  return Text(
                    '${Login.cookie}',
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              ),
              TextField(
                controller: _controllerAccount,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0), hintText: '请输入账号'),
                autofocus: false,
              ),
              TextField(
                controller: _controllerPassWord,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0), hintText: '请输入密码'),
                autofocus: false,
              ),
              RaisedButton(
                onPressed: () {
                  login();
                },
                child: Text('跳转cart'),
              )
            ],
          ),
        ));
  }
}
