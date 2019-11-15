import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/member.dart';
import '../pages/count.dart';
import '../pages/http_demo.dart';
import '../pages/approve_step.dart';
import '../pages/list/list.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print('index>details goodsID is $goodsId');
  return MemberPage(goodsId);
});
Handler cartHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print('index>details goodsID is $goodsId');
  return CartPage(goodsId);
});
Handler httpDemoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HttpDemo();
});
Handler approveStepHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ApproveStep();
});
Handler loginPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ListPage();
});
