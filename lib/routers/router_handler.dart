import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/member.dart';
import '../pages/count.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MemberPage();
});
Handler cartHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CartPage();
});
