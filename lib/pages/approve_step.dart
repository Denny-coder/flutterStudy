import 'package:flutter/material.dart';
import '../const/dimens.dart';
import '../widgets/my_stepper.dart';

class ApproveStep extends StatefulWidget {
  @override
  _ApproveStepState createState() => _ApproveStepState();
}

class _ApproveStepState extends State<ApproveStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('订单跟踪'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(top: 21.0, left: 16.0, right: 16.0),
                child: Text("订单编号：14562364879"),
              ),
              MyStepper(
                physics: BouncingScrollPhysics(),
                currentStep: 4 - 1,
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(); //操作按钮置空
                },
                steps: List.generate(4, (i) => _buildStep(i)),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> _titleList = ["订单已完成", "开始配送", "等待配送", "收到新订单"];
  List<String> _timeList = [
    "2018/08/30 13:30",
    "2018/08/30 11:30",
    "2018/08/30 9:30",
    "2018/08/30 9:00"
  ];
  MyStep _buildStep(int index) {
    Color primaryColor = Theme.of(context).primaryColor;
    return MyStep(
      title: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Text(_titleList[index],
            style: index == 0
                ? TextStyle(
                    fontSize: Dimens.font_sp14,
                    color: primaryColor,
                  )
                : Theme.of(context).textTheme.body1),
      ),
      subtitle: Text(_timeList[index],
          style: index == 0
              ? TextStyle(
                  fontSize: Dimens.font_sp12,
                  color: primaryColor,
                )
              : Theme.of(context).textTheme.subtitle),
      content: Text(""),
      isActive: index == 0,
      // TODO 这里的状态图标无法修改，暂时使用原生的。应该可以复制Step代码修改一下。
      state: index == 0 ? MyStepState.complete : MyStepState.indexed,
    );
  }
}
