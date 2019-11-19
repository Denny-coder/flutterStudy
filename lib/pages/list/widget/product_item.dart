import 'package:flutter/material.dart';
import 'package:myfirstflutter/widgets/load_image.dart';
import 'package:myfirstflutter/res/resources.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key key,
      @required this.data,
      @required this.index,
      @required this.selectIndex,
      @required this.onTapMenu,
      @required this.onTapEdit,
      @required this.onTapOperation,
      @required this.onTapDelete,
      @required this.onTapMenuClose,
      @required this.animation})
      : super(key: key);

  final ProductList data;
  final int index;
  final int selectIndex;
  final Function onTapMenu;
  final Function onTapEdit;
  final Function onTapOperation;
  final Function onTapDelete;
  final Function onTapMenuClose;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        children: <Widget>[
                          LoadImage(data.bannerUrl, width: 132.0, height: 90.0),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 132.0,
                              child: Center(
                                child: Text(
                                  '已有4人浏览',
                                  style: TextStyle(
                                      fontSize: Dimens.font_sp10,
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0),
                                  Color.fromRGBO(0, 0, 0, 0.4)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                            ),
                          )
                        ],
                      )),
                  Gaps.hGap8,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data.houseName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: Dimens.gap_dp16)),
                        Gaps.vGap3,
                        Text("2室1厅/86.93㎡/南 北/海尔地产·山海湾",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromRGBO(128, 134, 149, 1))),
                        Gaps.vGap3,
                        Row(
                          children: <Widget>[
                            Offstage(
                              // 类似于gone
                              offstage: index % 3 != 0,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                margin: const EdgeInsets.only(right: 4.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).errorColor,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                height: 16.0,
                                child: const Text(
                                  "立减",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp10),
                                ),
                              ),
                            ),
                            Opacity(
                              // 修改透明度实现隐藏，类似于invisible
                              opacity: index % 2 != 0 ? 0.0 : 1.0,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                height: 16.0,
                                alignment: Alignment.center,
                                child: const Text(
                                  "社区币抵扣",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp10),
                                ),
                              ),
                            )
                          ],
                        ),
                        Gaps.vGap3,
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Row(
                                children: <Widget>[
                                  Text("1127万",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: Dimens.gap_dp16,
                                          color:
                                              Color.fromRGBO(255, 87, 35, 1))),
                                  Container(
                                    padding: EdgeInsets.only(left: 5, top: 3),
                                    child: Text("成交均价",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: Dimens.gap_dp12,
                                            color: Color.fromRGBO(
                                                128, 134, 149, 1))),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                children: <Widget>[
                                  Text("21123万",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: Dimens.gap_dp16,
                                          color: Color.fromRGBO(0, 0, 0, 1))),
                                  Container(
                                    padding: EdgeInsets.only(left: 5, top: 3),
                                    child: Text("现价",
                                        style: TextStyle(
                                            fontSize: Dimens.gap_dp12,
                                            color: Color.fromRGBO(
                                                128, 134, 149, 1))),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
