import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myfirstflutter/util/toast.dart';
import 'package:myfirstflutter/net/dio_util.dart';
import 'package:myfirstflutter/widgets/app_bar.dart';
import 'package:myfirstflutter/pages/list/models/map_model.dart';
import 'package:myfirstflutter/pages/info/models/info_model.dart';
import 'package:myfirstflutter/provider/basic_data_provider.dart';

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
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '资产详情',
        // backgroundColor:Colors.blue,
      ),
      body:
          _infoData.houseName == null ? SizedBox() : Text(_infoData.houseName),
    );
  }
}
