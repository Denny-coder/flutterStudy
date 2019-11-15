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
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Number(),
            MyButton(),
            MyButtonToMember(),
          ],
        )));
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    return Wrap(children: <Widget>[
      RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Text('递增'),
      )
    ]);
  }
}

class MyButtonToMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
      onPressed: () {
        Application.router.navigateTo(context, "/cart?id=cart",
            transition: TransitionType.fadeIn);
      },
      child: Text('跳转cart'),
    ));
  }
}
