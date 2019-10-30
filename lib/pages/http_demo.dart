import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'data/row.dart';

class HttpDemo extends StatefulWidget {
  @override
  _HttpDemoState createState() => _HttpDemoState();
}

class _HttpDemoState extends State<HttpDemo> {
  // 输入框
  String _criteria = '';
  TextEditingController _controller = new TextEditingController();
  List<RowData> _tableData = new List<RowData>();
  int groupValue = 1;
  onChange(val) {
    setState(() {
      groupValue = val;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _criteria = _controller.value.text;
      });
    });
    getHttp(_criteria);
  }

  void getHttp(String name) async {
    List<RowData> serverDataList = new List();
    try {
      Response response;
      Dio dio = new Dio();
      dio.options.headers = {
        'X-Token':
            'eyJkYXRhIjp7ImFjY291bnQiOiJhZG1pbiIsInB3ZCI6Inp4MTIzNDU2In0sImNyZWF0ZWQiOjI2MjA2NjQyLCJleHAiOjMwfQ==.LrYXitJWHK++0XrSrfZXOD8tfQapWLi7AbtnaS5Tz6s=',
        'Cookie':
            'L_ID=5a979010bbfb391a6c5df4be; Admin-Token=eyJkYXRhIjp7ImFjY291bnQiOiJhZG1pbiIsInB3ZCI6Inp4MTIzNDU2In0sImNyZWF0ZWQiOjI2MjA2NjQyLCJleHAiOjMwfQ==.LrYXitJWHK++0XrSrfZXOD8tfQapWLi7AbtnaS5Tz6s='
      };
      response = await dio
          .post("http://student.bestzhengke.com/api/list/getTeach", data: {
        "major": "",
        "classes": "",
        "s_name": name,
        "pageNum": 1,
        "schoolnum": "",
        "pageSize": 5
      });
      print(response.data['code']);
      if (response.data['code'] == 200) {
        for (dynamic data in response.data['result']) {
          RowData hotMovieData = RowData.fromJson(data);
          serverDataList.add(hotMovieData);
        }
        setState(() {
          _tableData = serverDataList;
        });
      }
    } catch (e) {
      return print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http Demo'),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                child: Wrap(
                  children: <Widget>[
                    RadioListTile<int>(
                        title: const Text('教师'),
                        value: 1,
                        groupValue: groupValue, //当value和groupValue一致的时候则选中
                        onChanged: (T) {
                          onChange(T);
                        }),
                    RadioListTile(
                        title: const Text('学生'),
                        value: 2,
                        groupValue: groupValue,
                        onChanged: (T) {
                          onChange(T);
                        }),
                  ],
                ),
              ),
              Container(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      helperText: '请输入姓名'),
                  autofocus: false,
                ),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    getHttp(_criteria);
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
