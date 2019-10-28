import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';
import '../routers/application.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPage createState() => new _CartPage();
}

class _CartPage extends State<CartPage> {
  List<String> _tabBarData = ['订单反馈', '其他反馈', '我的反馈'];
  int _currenIndex = 0; // 当前选中的tabbar
  double _tabbarHeight = 30; // 当前选中的tabbar
  Color _backGroundColor = Colors.blue[400]; // 选中的tab的背景色及边框颜色
  Map<int, Widget> _tabbarView = {
    0: Text('订单反馈'),
    1: Text('其他反馈'),
    2: Text('我的反馈'),
  };

  List<Widget> _tabbarWidget(List<String> list) {
    List<Widget> _listWidget = [];
    for (int i = 0, len = _tabBarData.length; i < len; i++) {
      _listWidget.add(Expanded(
        child: new Ink(
          height: _tabbarHeight,
          //用ink圆角矩形
          decoration: new BoxDecoration(
            //不能同时”使用Ink的变量color属性以及decoration属性，两个只能存在一个
            color: _currenIndex == i ? _backGroundColor : Colors.white,
            //设置圆角
            borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
          ),
          child: new InkWell(
            //圆角设置,给水波纹也设置同样的圆角
            //如果这里不设置就会出现矩形的水波纹效果
            borderRadius: new BorderRadius.circular(25.0),
            //设置点击事件回调
            onTap: () {
              this.setState(() {
                _currenIndex = i;
              });
            },
            child: Center(
              child: Text(
                _tabBarData[i],
                style: TextStyle(
                    color: _currenIndex == i ? Colors.white : _backGroundColor),
              ),
              // padding: _paddingMain,
            ),
          ),
        ),
        flex: 1,
      ));
    }
    return _listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  semanticLabel: 'Close',
                ),
                onPressed: () {
                  Application.router.navigateTo(context, "/detail");
                }),
            title: const Text('意见反馈'),
            centerTitle: true),
        body: Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  border: new Border.all(
                      color: _backGroundColor, width: 1), // 边色与边宽度
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                child: Flex(
                  // mainAxisSize: MainAxisSize.min,
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _tabbarWidget(_tabBarData),
                ),
              ),
              _tabbarView[_currenIndex]
            ])));
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.display1,
          );
        },
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
      onPressed: () {
        Provide.value<Counter>(context).increment();
      },
      child: Text('递增'),
    ));
  }
}

class MyButtonToMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
      onPressed: () {
        Application.router.navigateTo(context, "/detail");
      },
      child: Text('跳转detail'),
    ));
  }
}
