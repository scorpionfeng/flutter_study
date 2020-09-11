import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterStudy/models/cacheConfig.dart';
import 'package:flutterStudy/models/profile.dart';
import 'package:flutterStudy/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cacheobject.dart';

const _themes=<MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global{
  static SharedPreferences _pres;
  static Profile profile= Profile();

  static NetCache netCache=NetCache();

static List<MaterialColor> get themes =>_themes;

static bool get isRelease=>bool.fromEnvironment("dart.vm.product");

static Future init() async{
  _pres=await SharedPreferences.getInstance();
  var _profile=_pres.getString("profile");
  if(_profile!=null){
    try{
      profile=Profile.fromJson(jsonDecode(_profile));
    }catch(e){
      print(e);
    }
  }


  profile.cache=profile.cache?? CacheConfig()
  ..enable=true
  ..maxAge=3600
  ..maxCount=100;

  //Git.init();
}

static saveProfile()=>
    _pres.setString("profile", jsonEncode(profile.toJson()));

}

class ProfileChangeNoftifier extends ChangeNotifier{
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}

class UserModel extends ProfileChangeNoftifier{
  User get user=>_profile.user;
  bool get isLogin=>user!=null;

  set user(User user){
    if(user?.login!=_profile.user?.login){
      _profile.lastLogin=_profile.user?.login;
      _profile.user=user;
      notifyListeners();
    }
  }
}

class LocaleModel extends ProfileChangeNoftifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  // 获取当前Locale的字符串表示
  String get locale => _profile.locale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNoftifier{
  ColorSwatch get theme=> Global.themes.firstWhere((element) => element.value==_profile.theme,orElse: ()=>Colors.blue);
  set theme(ColorSwatch color){
    if(color!=theme){
      _profile.theme=color[500].value;
      notifyListeners();
    }
  }
}

class LocalManager extends ProfileChangeNoftifier{
  Locale getLocale(){
    if(_profile.locale==null) return null;
    var t=_profile.locale.split("_");
    return Locale(t[0],t[1]);
  }

  String get locale=>_profile.locale;

  set locale(String locale){
    if(locale!=_profile.locale){
      _profile.locale=locale;
      notifyListeners();
    }
  }
}