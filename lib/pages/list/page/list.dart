import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:myfirstflutter/util/toast.dart';
import 'package:myfirstflutter/widgets/app_bar.dart';
import 'package:myfirstflutter/widgets/my_refresh_list.dart';
import 'package:myfirstflutter/widgets/state_layout.dart';
import 'package:myfirstflutter/net/dio_util.dart';
import 'package:myfirstflutter/provider/basic_data_provider.dart';
import 'package:myfirstflutter/routers/fluro_navigator.dart';
import '../widget/product_item.dart';
import '../models/product_model.dart';
import '../models/map_model.dart';
import '../../info/info_router.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  List<ProductList> _tableData = new List<ProductList>();
  int _total;
  Animation<double> _animation;
  AnimationController _controller;
  int _page;
  BasicDataProvider basicDataProvider = BasicDataProvider();
  Map<String, String> houseTagsList = new Map(); // 标签
  Map<String, String> houseTypeList = new Map(); // 户型
  Map<String, String> houseDirectionList = new Map(); // 朝向
  @override
  void initState() {
    super.initState();
    // 初始化动画控制
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    // 动画曲线
    CurvedAnimation _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _animation = new Tween(begin: 0.0, end: 1.1).animate(_curvedAnimation);
    setState(() {
      _total = 0;
      _page = 1;
    });
    basicDataProvider.setbasicData((basicData) {
      for (dynamic data in basicData['HOUSE_DIRECTION']) {
        HouseDirection houseDirection = HouseDirection.fromJson(data);
        setState(() {
          houseDirectionList[houseDirection.code] = houseDirection.codeName;
        });
      }
      for (dynamic data in basicData['HOUSE_TYPE']) {
        HouseType houseType = HouseType.fromJson(data);
        setState(() {
          houseTypeList[houseType.code] = houseType.codeName;
        });
      }
      for (dynamic data in basicData['HOUSE_TAGS']) {
        HouseTags houseTags = HouseTags.fromJson(data);
        setState(() {
          houseTagsList[houseTags.code] = houseTags.codeName;
        });
      }
      _refresh();
    });
  }

  Future _refresh() async {
    setState(() {
      _page = 1;
    });
    await Future.delayed(Duration(seconds: 0), () {
      this._commonLoad(1);
    });
  }

  Future _loadMore() async {
    setState(() {
      _page = _page + 1;
    });
    await Future.delayed(Duration(seconds: 0), () {
      this._commonLoad(0);
    });
  }

  Future _commonLoad(int type) async {
    List<ProductList> productDataList = new List();
    try {
      await DioUtils.instance.requestNetwork(Method.post,
          "houseinfoController/getListPage?token=crm:wecat:token0000Fu&type=1",
          isList: true,
          params: {
            "showStatus": 1,
            "rows": 10,
            "page": _page,
            "houseName": "",
            "type": ""
          }, onSuccessList: (data) {
        if (data['success']) {
          for (dynamic data in data['data']['list']) {
            ProductList productData = ProductList.fromJson(data);
            productData.houseType = houseTypeList[productData.houseType];
            productData.driection = houseDirectionList[productData.driection];
            productData.tags =
                productData.tags.map((f) => houseTagsList[f]).toList();
            productDataList.add(productData);
          }
          if (type == 1) {
            setState(() {
              _total = data['data']['total'];
              _tableData = productDataList;
            });
          } else {
            setState(() {
              _tableData.addAll(productDataList);
            });
          }
        } else {
          setState(() {
            _total = 0;
            _tableData = new List<ProductList>();
          });
        }
      });
    } on DioError catch (e) {
      if (e.response != null) {
        setState(() {
          _total = 0;
          _tableData = new List<ProductList>();
        });
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
            centerTitle: '资产处置',
            // backgroundColor:Colors.blue,
            isBack: false),
        body: DeerListView(
            stateType: StateType.loading,
            itemCount: _tableData.length,
            onRefresh: _refresh,
            total: _total,
            hasMore: _tableData.length < _total,
            loadMore: _loadMore,
            itemBuilder: (_, index) {
              return GestureDetector(
                child: ProductItem(
                  index: index,
                  data: _tableData[index],
                  selectIndex: 0,
                  onTapMenu: () {},
                  onTapEdit: () {},
                  onTapOperation: () {},
                  onTapDelete: () {},
                  onTapMenuClose: () {},
                  animation: _animation,
                ),
                onTap: () {
                  NavigatorUtils.push(context,
                      '${InfoRouter.houseInfoPage}?id=${_tableData[index].id}&status=${_tableData[index].processStatus}');
                  print(_tableData[index].houseName);
                },
              );
            }));
  }
}
