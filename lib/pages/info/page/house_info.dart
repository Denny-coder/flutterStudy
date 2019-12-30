import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myfirstflutter/util/toast.dart';
import 'package:myfirstflutter/net/dio_util.dart';
import 'package:myfirstflutter/widgets/app_bar.dart';
import 'package:myfirstflutter/pages/list/models/map_model.dart';
import 'package:myfirstflutter/pages/info/models/info_model.dart';
import 'package:myfirstflutter/provider/basic_data_provider.dart';
import 'package:myfirstflutter/widgets/swiper/swiper.dart';

class HouseInfo extends StatefulWidget {
  const HouseInfo({Key key, this.status, this.id}) : super(key: key);
  final String status;
  final String id;
  @override
  _HouseInfoState createState() => _HouseInfoState();
}

class _HouseInfoState extends State<HouseInfo> {
  BasicDataProvider basicDataProvider = BasicDataProvider();
  Map<String, String> houseTypeList = new Map(); // 户型
  Map<String, String> houseUseList = new Map(); // 用途
  Map<String, String> houseFloorList = new Map(); // 楼层
  Map<String, String> houseFitUpList = new Map(); // 装修
  Map<String, String> houseDirectionList = new Map(); // 朝向
  List<String> images = [
    'https://img.aiwoke.com.cn/caifu/crm/house_info/20191105175411_313725.jpg?Expires=1893036827&OSSAccessKeyId=LTAIezDDhCzqtdOq&Signature=CADjmgpLmbq5UWHEad1bZP%2BoxY8%3D',
    'https://img.aiwoke.com.cn/caifu/crm/house_info/20191105175418_165688.jpg?Expires=1893036827&OSSAccessKeyId=LTAIezDDhCzqtdOq&Signature=p9lhNavLFGcb%2FIDhEOe0Cnes9ag%3D',
    'https://img.aiwoke.com.cn/caifu/crm/house_info/20191105175425_608708.jpg?Expires=1893036827&OSSAccessKeyId=LTAIezDDhCzqtdOq&Signature=ZNdKnGGep9OcXGyf4h9eSDWI%2B8U%3D',
  ];
  InfoData _infoData = InfoData(
      0,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      null,
      '',
      '',
      '',
      '',
      '',
      null,
      '',
      null,
      '',
      '',
      null,
      '',
      '',
      '',
      '',
      '',
      '',
      ''); // 详情数据
  @override
  void initState() {
    super.initState();
    basicDataProvider.setbasicData((basicData) {
      for (dynamic data in basicData['HOUSE_TYPE']) {
        HouseType houseType = HouseType.fromJson(data);
        setState(() {
          houseTypeList[houseType.code] = houseType.codeName;
        });
      }
      for (dynamic data in basicData['HOUSE_USE']) {
        HouseUse houseUse = HouseUse.fromJson(data);
        setState(() {
          houseUseList[houseUse.code] = houseUse.codeName;
        });
      }
      for (dynamic data in basicData['HOUSE_FLOOR']) {
        HouseFloor houseFloor = HouseFloor.fromJson(data);
        setState(() {
          houseFloorList[houseFloor.code] = houseFloor.codeName;
        });
      }
      for (dynamic data in basicData['HOUSE_FITUP']) {
        HouseFitUp houseFitUp = HouseFitUp.fromJson(data);
        setState(() {
          houseFitUpList[houseFitUp.code] = houseFitUp.codeName;
        });
      }
      for (dynamic data in basicData['HOUSE_DIRECTION']) {
        HouseDirection houseDirection = HouseDirection.fromJson(data);
        setState(() {
          houseDirectionList[houseDirection.code] = houseDirection.codeName;
        });
      }
      _getInfo();
    });
  }

  Future _getInfo() async {
    try {
      await DioUtils.instance.requestNetwork(Method.post,
          "houseinfoController/selectByPrimaryKey?token=crm:wecat:token0000Fu&type=1",
          isList: true, params: {'id': widget.id}, onSuccessList: (data) {
        print('----------data-------------');
        if (data['success']) {
          InfoData infoData = InfoData.fromJson(data['data']);
          print(infoData.houseName);
          setState(() {
            _infoData = infoData;
          });
        }
      });
    } on DioError catch (e) {
      if (e.response != null) {
        Toast.show("暂无权限");
      } else {
        // Something happened in setting up or sending the request that triggered an Error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle commonColor = TextStyle(
      color: Color.fromRGBO(255, 87, 35, 1),
    );
    final Widget commonLine = Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      width: double.infinity,
      height: 2.0,
      color: Color.fromRGBO(232, 234, 236, 1),
    );
    return Scaffold(
        appBar: MyAppBar(
          centerTitle: '资产详情',
          // backgroundColor:Colors.blue,
        ),
        body: Column(
          children: <Widget>[
            Swiper(images: images),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              constraints: BoxConstraints(
                  minWidth: double.infinity, maxWidth: double.infinity),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_infoData.houseName,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('110万', style: commonColor),
                            Text('成交均价')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('9X万', style: commonColor),
                            Text('现价')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('三室一厅', style: commonColor),
                            Text('房型')
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('61㎡', style: commonColor),
                            Text('建筑面积')
                          ],
                        ),
                      ],
                    ),
                  ),
                  commonLine,
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('110万', style: commonColor),
                                Text('成交均价')
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('9X万', style: commonColor),
                                Text('现价')
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('110万', style: commonColor),
                                Text('成交均价')
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('9X万', style: commonColor),
                                Text('现价')
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
        // _infoData.houseName == null ? SizedBox() : Text(_infoData.houseName),
        );
  }
}
