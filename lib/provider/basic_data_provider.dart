import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myfirstflutter/net/dio_util.dart';

class BasicDataProvider<T> extends ChangeNotifier {
  Map<String, dynamic> _basicData;

  Map<String, dynamic> get basicData => _basicData;

  Future setbasicData(Function onSuccess) async {
    if (_basicData == null) {
      try {
        await DioUtils.instance.requestNetwork(Method.post,
            "crmCodeController/findAll?token=crm:wecat:token0000Fu&type=1",
            onSuccess: (data) {
          _basicData = data['data'];
          onSuccess(_basicData);
        });
      } on DioError catch (e) {
        print(e);
      }
    } else {
      onSuccess(_basicData);
    }
  }
}
