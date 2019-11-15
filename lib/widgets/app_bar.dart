import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfirstflutter/res/resources.dart';
import 'package:myfirstflutter/util/theme_utils.dart';
import 'package:myfirstflutter/widgets/load_image.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key key,
      this.backgroundColor,
      this.title: "",
      this.centerTitle: "",
      this.actionName: "",
      this.backImg: "assets/images/ic_back_black.png",
      this.onPressed,
      this.isBack: true})
      : super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = ThemeUtils.getBackgroundColor(context);
    } else {
      _backgroundColor = backgroundColor;
    }

    SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                //设置四周圆角 角度
                //设置四周边框
                border: new Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: centerTitle.isEmpty
                          ? Alignment.centerLeft
                          : Alignment.center,
                      width: double.infinity,
                      child: Text(title.isEmpty ? centerTitle : title,
                          style: TextStyle(
                            fontSize: Dimens.font_sp18,
                            color: _overlayStyle == SystemUiOverlayStyle.light
                                ? Colours.dark_text
                                : Colours.text,
                          )),
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    )
                  ],
                ),
                isBack
                    ? IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.maybePop(context);
                        },
                        tooltip: 'Back',
                        padding: const EdgeInsets.all(12.0),
                        icon: Image.asset(
                          backImg,
                          color: _overlayStyle == SystemUiOverlayStyle.light
                              ? Colours.dark_text
                              : Colours.text,
                        ),
                      )
                    : Gaps.empty,
                Positioned(
                  right: 5.0,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        buttonTheme: ButtonThemeData(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      minWidth: 60.0,
                    )),
                    child: actionName.isEmpty
                        ? Container(
                            height: 25,
                            width: 60,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              //背景
                              //设置四周圆角 角度
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              //设置四周边框
                              border: new Border.all(
                                  width: 1, color: Colors.black38),
                            ),
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              direction: Axis.horizontal,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    print(1);
                                  },
                                  child: LoadAssetImage(
                                    "bar/dian",
                                    width: 16.0,
                                    height: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  width: 1.0,
                                  height: 10.0,
                                  color: Colors.black38,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(2);
                                  },
                                  child: LoadAssetImage(
                                    "bar/circle",
                                    width: 12.0,
                                    height: 12.0,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          )
                        : FlatButton(
                            child:
                                Text(actionName, key: const Key('actionName')),
                            textColor:
                                _overlayStyle == SystemUiOverlayStyle.light
                                    ? Colours.dark_text
                                    : Colours.text,
                            highlightColor: Colors.transparent,
                            onPressed: onPressed,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
