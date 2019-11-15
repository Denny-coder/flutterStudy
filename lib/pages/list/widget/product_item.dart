import 'package:flutter/material.dart';
import 'package:myfirstflutter/widgets/load_image.dart';
import 'package:myfirstflutter/res/resources.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key key,
      @required this.img,
      @required this.index,
      @required this.selectIndex,
      @required this.onTapMenu,
      @required this.onTapEdit,
      @required this.onTapOperation,
      @required this.onTapDelete,
      @required this.onTapMenuClose,
      @required this.animation})
      : super(key: key);

  final String img;
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
                          LoadImage(img, width: 132.0, height: 90.0),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 110.0,
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
                        const Text("山海湾·品质小区 南北通透",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: Dimens.gap_dp16)),
                        const Text("2室1厅/86.93㎡/南 北/海尔地产·山海湾",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromRGBO(128, 134, 149, 1))),
                        Gaps.vGap5,
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
                        Gaps.vGap4,
                        Row(
                          children: <Widget>[
                            Text("157万",
                                style: TextStyle(
                                    height: 0.2,
                                    fontSize: Dimens.gap_dp16,
                                    color: Color.fromRGBO(255, 87, 35, 1))),
                            Text("成交均价",
                                style: TextStyle(
                                    // height: 20,
                                    color: Color.fromRGBO(128, 134, 149, 1))),
                            Text("210万",
                                style: TextStyle(
                                    fontSize: Dimens.gap_dp16,
                                    color: Color.fromRGBO(0, 0, 0, 1))),
                            Text("现价",
                                style: TextStyle(
                                    height: 0.5,

                                    // height: 20,
                                    color: Color.fromRGBO(128, 134, 149, 1)))
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
