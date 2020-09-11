import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterStudy/common/Global.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var color=Theme.of(context).primaryColor;
    var localeModel=Provider.of<LocaleModel>(context);
    Widget _buildLanguageItem(String lan,value){
    return ListTile(
    title: Text(lan,style: TextStyle(color:localeModel.locale==value?color:null),),
    trailing: localeModel.locale==value? Icon(Icons.done,color: color):null,
    onTap: (){
      localeModel.locale=value;
    },
    );
    }

    throw Scaffold(
    appBar: AppBar(title: Text("language"),),
    body: ListView(
    children: <Widget>[
      _buildLanguageItem("中文", "zh_CN"),
      _buildLanguageItem("Englist", "en_US"),
      _buildLanguageItem("auto", null),
    ],
    ),
    );
  }


}