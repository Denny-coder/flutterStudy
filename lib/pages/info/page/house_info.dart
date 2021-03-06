import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myfirstflutter/util/toast.dart';
import 'package:myfirstflutter/net/dio_util.dart';
import 'package:myfirstflutter/widgets/app_bar.dart';
import 'package:myfirstflutter/pages/list/models/map_model.dart';
import 'package:myfirstflutter/pages/info/models/info_model.dart';
import 'package:myfirstflutter/provider/basic_data_provider.dart';
import 'package:myfirstflutter/widgets/swiper/swiper.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:myfirstflutter/widgets/my_stepper.dart';
import 'package:myfirstflutter/res/dimens.dart';

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
  List houseBuyStatusnList = new List(); // 购置流程
  int currentStatus = -1; // 购置流程
  LatLng _amapMark;
  AmapController _controller;
  List<Marker> _markers = [];
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
      for (dynamic data in basicData['HOUSE_BUY_STATUS']) {
        HouseBuyStatus houseBuyStatus = HouseBuyStatus.fromJson(data);
        setState(() {
          houseBuyStatusnList.add(houseBuyStatus);
        });
      }
      _getInfo();
    });
  }

  _getAmap(String lonLat) async {
    try {
      Response response = await Dio().get(
          "https://restapi.amap.com/v3/assistant/coordinate/convert",
          queryParameters: {
            "locations": lonLat,
            "coordsys": "baidu",
            "output": "JSON",
            "key": "5499e618f5a15fadc32a6d9f30dbd749"
          });
      AmapLatLng amapLatLng = AmapLatLng.fromJson(response.data);
      if (amapLatLng.infocode == '10000') {
        double lng = double.parse(amapLatLng.locations.split(',')[0]);
        double lat = double.parse(amapLatLng.locations.split(',')[1]);
        // _amapMark=
        print('----response----');
        LatLng(lat, lng);
        setState(() {
          _amapMark = LatLng(lat, lng);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _getInfo() async {
    try {
      await DioUtils.instance.requestNetwork(Method.post,
          "houseinfoController/selectByPrimaryKey?token=crm:wecat:token0000Fu&type=1",
          isList: true, params: {'id': widget.id}, onSuccessList: (data) {
        print('----------data-------------');
        if (data['success']) {
          InfoData infoData = InfoData.fromJson(data['data']);
          // 购置流程激活
          for (int i = 0; i < houseBuyStatusnList.length; i++) {
            if (int.parse(infoData.processStatus) >=
                int.parse(houseBuyStatusnList[i].code)) {
              setState(() {
                currentStatus = i;
              });
            } else {
              break;
            }
          }
          setState(() {
            _infoData = infoData;
          });
          _getAmap(infoData.lonLat);
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

  final TextStyle commonColor = TextStyle(
    color: Color.fromRGBO(255, 87, 35, 1),
  );
  final TextStyle labelStyle = TextStyle(
    color: Color.fromRGBO(158, 167, 180, 1),
  );
  final TextStyle valueStyle = TextStyle(
    color: Color.fromRGBO(23, 35, 61, 1),
  );
  final Widget commonLine = Container(
    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
    width: double.infinity,
    height: 1.0,
    color: Color.fromRGBO(232, 234, 236, 1),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          centerTitle: '资产详情',
          // backgroundColor:Colors.blue,
        ),
        body: _amapMark == null
            ? SizedBox()
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Swiper(images: images),
                    Container(
                      margin:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                                    Text('成交均价', style: labelStyle)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('9X万', style: commonColor),
                                    Text('现价', style: labelStyle)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('三室一厅', style: commonColor),
                                    Text('房型', style: labelStyle)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('61㎡', style: commonColor),
                                    Text('建筑面积', style: labelStyle)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          commonLine,
                          Container(
                            constraints: BoxConstraints.tightFor(height: 120.0),
                            child: Flex(
                              direction: Axis.vertical,
                              children: <Widget>[
                                infoItem(
                                  '单价',
                                  '55555元/平',
                                  '朝向',
                                  '朝南',
                                ),
                                infoItem(
                                  '楼层',
                                  '低楼层(共3层)',
                                  '装修',
                                  '简装',
                                ),
                                infoItem(
                                  '年代',
                                  '2000年建成',
                                  '用途',
                                  '普通住宅',
                                ),
                                infoItem(
                                  '小区',
                                  '北京天华园三里二区北京天华园三里二区',
                                  '建筑面积',
                                  '230.13㎡',
                                ),
                                infoItem(
                                  '套内面积',
                                  '230.13㎡',
                                  '房屋用途',
                                  '普通住宅',
                                ),
                              ],
                            ),
                          ),
                          commonTitle('房源介绍'),
                          commonLine,
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text('核心卖点',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ),
                          Text(
                              '核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点核心卖点 ',
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(101, 113, 128, 1))),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                            child: Text('增值服务',
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ),
                          Container(
                              constraints:
                                  BoxConstraints.tightFor(height: 80.0),
                              child: Flex(
                                direction: Axis.vertical,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                            IconData(0xe6b2,
                                                fontFamily: 'iconfont'),
                                            size: 18,
                                            color: Color.fromRGBO(
                                                254, 194, 43, 1)),
                                      ),
                                      Text('购房资格咨询服务')
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                            IconData(0xe6b2,
                                                fontFamily: 'iconfont'),
                                            size: 18,
                                            color: Color.fromRGBO(
                                                254, 194, 43, 1)),
                                      ),
                                      Text('房屋过户咨询服务')
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                            IconData(0xe6b2,
                                                fontFamily: 'iconfont'),
                                            size: 18,
                                            color: Color.fromRGBO(
                                                254, 194, 43, 1)),
                                      ),
                                      Text('贷款咨询服')
                                    ],
                                  ),
                                ],
                              )),
                          commonLine,
                          Container(
                            constraints: BoxConstraints.tightFor(height: 20.0),
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                          IconData(0xe646,
                                              fontFamily: 'iconfont'),
                                          size: 20,
                                          color:
                                              Color.fromRGBO(39, 146, 255, 1)),
                                    ),
                                    Text('北京天华苑')
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '查看',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(39, 146, 255, 1)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Icon(
                                          IconData(0xe60b,
                                              fontFamily: 'iconfont'),
                                          size: 18,
                                          color:
                                              Color.fromRGBO(39, 146, 255, 1)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   constraints: BoxConstraints.tightFor(height: 200.0),
                          //   margin: EdgeInsets.only(bottom: 10.0),
                          //   child: AmapView(
                          //     centerCoordinate: _amapMark,
                          //     showZoomControl: false,
                          //     maskDelay: Duration(milliseconds: 500),
                          //     onMapCreated: (controller) async {
                          //       _controller = controller;
                          //       print('-------LatLng--------');
                          //       print(LatLng(39.908775, 116.406315));
                          //       print(_amapMark);
                          //       final marker = await _controller?.addMarker(
                          //         MarkerOption(
                          //           latLng: _amapMark,
                          //           title: '北京',
                          //           snippet: '描述',
                          //           iconUri: Uri.parse(
                          //               'assets/images/my/position.png'),
                          //           imageConfig:
                          //               createLocalImageConfiguration(context),
                          //           infoWindowEnabled: false,
                          //         ),
                          //       );
                          //       _markers.add(marker);
                          //     },
                          //   ),
                          // ),
                          commonTitle('购置流程'),
                          commonLine,
                          MyStepper(
                            physics: BouncingScrollPhysics(),
                            controlsBuilder: (BuildContext context,
                                {VoidCallback onStepContinue,
                                VoidCallback onStepCancel}) {
                              return Row(); //操作按钮置空
                            },
                            steps: List.generate(houseBuyStatusnList.length,
                                (i) => _buildStep(i)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }

  MyStep _buildStep(int index) {
    Color primaryColor = Theme.of(context).primaryColor;
    return MyStep(
      title: Text(houseBuyStatusnList[index].codeName,
          style: index == currentStatus
              ? TextStyle(
                  fontSize: Dimens.font_sp14,
                  color: primaryColor,
                )
              : Theme.of(context).textTheme.body1),
      content: Text(""),
      isActive: index == currentStatus,
      // 这里的状态图标无法修改，暂时使用原生的。应该可以复制Step代码修改一下。
      state:
          index == currentStatus ? MyStepState.complete : MyStepState.indexed,
    );
  }

  Function commonTitle = (title) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            color: Color.fromRGBO(39, 146, 255, 1),
            width: 3.0,
            height: 14.0,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  };
  Function infoItem = (
    String labelLeft,
    String valueLeft,
    String labelRigth,
    String valueRigth,
  ) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.tightFor(width: 160.0, height: 30),
            child: Row(
              children: <Widget>[
                Text('$labelLeft:',
                    style: TextStyle(
                      color: Color.fromRGBO(158, 167, 180, 1),
                    )),
                Container(
                  constraints: BoxConstraints(maxWidth: 110.0),
                  child: Text(
                    '$valueLeft',
                    style: TextStyle(
                      color: Color.fromRGBO(23, 35, 61, 1),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints.tightFor(width: 175.0, height: 20),
            child: Row(
              children: <Widget>[
                Text('$labelRigth:',
                    style: TextStyle(
                      color: Color.fromRGBO(158, 167, 180, 1),
                    )),
                Container(
                  constraints: BoxConstraints(maxWidth: 110.0),
                  child: Text(
                    '$valueRigth',
                    style: TextStyle(
                      color: Color.fromRGBO(23, 35, 61, 1),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  };
}
