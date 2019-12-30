import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myfirstflutter/widgets/load_image.dart';

class Swiper extends StatefulWidget {
  const Swiper({Key key, this.images}) : super(key: key);
  final List<String> images;
  @override
  _State createState() => _State();
}

class _State extends State<Swiper> {
  PageController _pageController = PageController(
    initialPage: 1,
  );
  int _currentIndex = 1;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    if (widget.images.length > 0) {
      _setTimer();
    }
  }

//设置定时器
  _setTimer() {
    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      _pageController.animateToPage(_currentIndex + 1,
          duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    List addedImages = [];
    if (widget.images.length > 0) {
      addedImages
        ..add(widget.images[widget.images.length - 1])
        ..addAll(widget.images)
        ..add(widget.images[0]);
    }
    return AspectRatio(
      aspectRatio: 1.79,
      child: Stack(
        children: [
          NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification.depth == 0 &&
                  notification is ScrollStartNotification) {
                if (notification.dragDetails != null) {
                  _timer.cancel();
                }
              } else if (notification is ScrollEndNotification) {
                _timer.cancel();
                _setTimer();
              }
            },
            child: widget.images.length > 0
                ? PageView(
                    physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (page) {
                      int newIndex;
                      if (page == addedImages.length - 1) {
                        newIndex = 1;
                        _pageController.jumpToPage(newIndex);
                      } else if (page == 0) {
                        newIndex = addedImages.length - 2;
                        _pageController.jumpToPage(newIndex);
                      } else {
                        newIndex = page;
                      }
                      setState(() {
                        _currentIndex = newIndex;
                      });
                    },
                    children: addedImages
                        .map((item) => LoadImage(item, fit: BoxFit.fill))
                        .toList(),
                    // Container(
                    //       margin: EdgeInsets.all(10.0),
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(5.0),
                    //         child:
                    //              Image.asset(
                    //               item,
                    //               fit: BoxFit.cover,
                    //             ),
                    //       ),
                    //     ))
                    // .toList(),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 15.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.images
                  .asMap()
                  .map((i, v) => MapEntry(
                      i,
                      Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.only(left: 2.0, right: 2.0),
                        decoration: ShapeDecoration(
                            color: _currentIndex == i + 1
                                ? Colors.white
                                : Color.fromRGBO(0, 0, 0, 0.3),
                            shape: CircleBorder()),
                      )))
                  .values
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
