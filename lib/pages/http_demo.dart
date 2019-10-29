import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HttpDemo extends StatefulWidget {
  @override
  _HttpDemoState createState() => _HttpDemoState();
}

class Row {}

class _HttpDemoState extends State<HttpDemo> {
  // 输入框
  String _criteria = '';
  TextEditingController _controller = new TextEditingController();
  List _tableData = [];
  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        _criteria = _controller.value.text;
      });
    });
    getHttp(_criteria).then((onValue) {
      print(onValue['code']);
      if (onValue['code'] == 200) {
        print(onValue['result']);
        this.setState(() {
          _tableData = onValue['result'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      helperText: '请输入你喜欢的类型'),
                  autofocus: false,
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    getHttp(_criteria).then((onValue) {
                      print(onValue['code']);
                      if (onValue['code'] == 200) {
                        print(onValue['result']);
                        this.setState(() {
                          _tableData = onValue['result'];
                        });
                      }
                    });
                  },
                  child: Text('确认输入'),
                ),
              ),
              SizedBox(
                height: 300.0,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _tableData.length, // item 的个数
                  itemExtent: 50.0, // 如果为非null，则强制子项在滚动方向上具有给定范围
                  itemBuilder: (BuildContext context, int index) {
                    if (_tableData.length == 0) {
                      return null;
                    } else {
                      return ListTile(
                        title: Text(
                            "title ${_tableData[index].fullname}"), // item 标题
                        trailing: Icon(Icons.keyboard_arrow_right), // item 后置图标
                        dense: true, // item 直观感受是整体大小
                        contentPadding: EdgeInsets.all(10.0), // item 内容内边距
                        enabled: true,
                        onTap: () {
                          print('点击:$index');
                        }, // item onTap 点击事件
                        onLongPress: () {
                          print('长按:$index');
                        }, // item onLongPress 长按事件
                        selected: false, // item 是否选中状态
                      );
                    }
                  },
                ),
              )
            ],
          )),
    );
  }
}

Future getHttp(String name) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.headers = {
      'X-Token':
          'eyJkYXRhIjp7ImFjY291bnQiOiJhZG1pbiIsInB3ZCI6Inp4MTIzNDU2In0sImNyZWF0ZWQiOjI2MjA1NjcxLCJleHAiOjMwfQ==.T8DTmz9dscr76Hx6ljzHCFWNqrB3SMEGW8HJCgdM2a4=',
      'Cookie':
          'L_ID=5a979010bbfb391a6c5df4be; Admin-Token=eyJkYXRhIjp7ImFjY291bnQiOiJhZG1pbiIsInB3ZCI6Inp4MTIzNDU2In0sImNyZWF0ZWQiOjI2MjA1NjcxLCJleHAiOjMwfQ==.T8DTmz9dscr76Hx6ljzHCFWNqrB3SMEGW8HJCgdM2a4='
    };
    response = await dio
        .post("http://student.bestzhengke.com/api/list/getstudent", data: {
      "major": "",
      "classes": "",
      "s_name": name,
      "pageNum": 1,
      "schoolnum": "",
      "pageSize": 5
    });
    return response.data;
  } catch (e) {
    return print(e);
  }
}
