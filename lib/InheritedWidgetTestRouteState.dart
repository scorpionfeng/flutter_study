import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterStudy/ShareDataWidget.dart';

class InheritedDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State<InheritedDemo>{
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("dependencies change");
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  InheritedWidgetTestRouteState createState() => new InheritedWidgetTestRouteState();
}

class InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("widget内共享"),),
      body: ShareDataWidget( //使用ShareDataWidget
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: InheritedDemo(),//子widget中依赖ShareDataWidget
            ),
            FlatButton(
              child: Text("Increment"),
              //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
              onPressed: () => setState(() => ++count),
            )
          ],
        ),
      ),
    );
  }
}