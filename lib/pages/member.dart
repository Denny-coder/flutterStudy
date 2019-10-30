import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:provide/provide.dart';
import '../routers/application.dart';
import '../provide/counter.dart';

class MemberPage extends StatelessWidget {
  final String goodsId;
  MemberPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('member'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Number(),
              MyButton(),
              MyButtonToMember(),
            ],
          ),
        ));
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
        Application.router.navigateTo(context, "/cart?id=cart",
            transition: TransitionType.fadeIn,
            transitionDuration: Duration(milliseconds: 3000));
      },
      child: Text('跳转cart'),
    ));
  }
}
