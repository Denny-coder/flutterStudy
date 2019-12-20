import 'package:flutter/material.dart';
import 'package:myfirstflutter/widgets/load_image.dart';
import 'package:myfirstflutter/res/resources.dart';
import '../models/product.dart';

class ProductItem extends StatefulWidget {
  ProductItem(
      {Key key,
      @required this.data,
      @required this.index,
      this.houseType,
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
  final String houseType;
  final int selectIndex;
  final Function onTapMenu;
  final Function onTapEdit;
  final Function onTapOperation;
  final Function onTapDelete;
  final Function onTapMenuClose;
  final Animation<double> animation;
  @override
  _ProductItem createState() => _ProductItem();
}

class _ProductItem extends State<ProductItem> {
  Function tagsList = (tagsOption) {
    List<Widget> tags = List();
    for (var item in tagsOption) {
      tags.add(Offstage(
        // 类似于gone
        offstage: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          margin: const EdgeInsets.only(right: 4.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2.0),
          ),
          height: 16.0,
          child: Text(
            item,
            style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp10),
          ),
        ),
      ));
    }
    return tags;
  };
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
                          // 图片变灰
                          widget.data.processStatus == '99'
                              ? ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.saturation,
                                  ),
                                  child: LoadImage(widget.data.bannerUrl,
                                      width: 132.0, height: 90.0),
                                )
                              : LoadImage(widget.data.bannerUrl,
                                  width: 132.0, height: 90.0),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 132.0,
                              child: Center(
                                child: Text(
                                  '已有${widget.data.interestCount}人浏览',
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
                        Text(widget.data.houseName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: Dimens.gap_dp16)),
                        Gaps.vGap3,
                        Text(
                            "${widget.data.houseType}/${widget.data.floorArea}㎡/${widget.data.driection}/${widget.data.village}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromRGBO(128, 134, 149, 1))),
                        Gaps.vGap3,
                        Row(
                            children: widget.data.tags.length != 0
                                ? tagsList(widget.data.tags)
                                : [Gaps.vGap15]),
                        Gaps.vGap3,
                        widget.data.processStatus == '99'
                            ? Text('已售出')
                            : Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("${widget.data.sellPrice}万",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: Dimens.gap_dp16,
                                              color: Color.fromRGBO(
                                                  255, 87, 35, 1))),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 5, top: 3, right: 5),
                                        child: Text("成交均价",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontSize: Dimens.gap_dp12,
                                                color: Color.fromRGBO(
                                                    128, 134, 149, 1))),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("${widget.data.nowPrice}万",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: Dimens.gap_dp16,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1))),
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 5, top: 3),
                                        child: Text("现价",
                                            style: TextStyle(
                                                fontSize: Dimens.gap_dp12,
                                                color: Color.fromRGBO(
                                                    128, 134, 149, 1))),
                                      )
                                    ],
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
        // Positioned(
        //   right: 10,
        //   child: ,
        // )
      ],
    );
  }
}
