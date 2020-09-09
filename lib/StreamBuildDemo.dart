import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StreamBuildDemo extends StatelessWidget{

  Stream<int> counter(){
    return Stream.periodic(Duration(seconds: 1),(i)=>i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("stream demo")),
      body: StreamBuilder<int>(
        stream: counter(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text("Error : ${snapshot.error}");
          }
          switch(snapshot.connectionState){
            case ConnectionState.done:
              return Text("没有stream");
            case ConnectionState.waiting:
              return Text("等待数据 ");
            case ConnectionState.active:
              return Text("active: ${snapshot.data}");
            case ConnectionState.done:
              return Text("stream 关闭");
          }
          return null;
        },
      )
    );
  }
}