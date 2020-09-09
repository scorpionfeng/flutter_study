import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureBuildDemo extends StatelessWidget{

  Future<String> mockNetworkData() async{
    return Future.delayed(Duration(seconds: 2),()=>"我是互联网数据 ");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("future demo"),),
      body: FutureBuilder<String>(
        future: mockNetworkData(),
        builder: (context,snapshot){
          if(snapshot.connectionState== ConnectionState.done){
            if(snapshot.hasError){
              return Text("error : ${snapshot.error}");
            }else{
              return Text("Content :${snapshot.data}");
            }
          }else{
            return CircularProgressIndicator();
          }
        },
      )
    );
  }

}