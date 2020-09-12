import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterStudy/common/Global.dart';
import 'package:flutterStudy/routes/LoginRoute.dart';
import 'package:flutterStudy/routes/ThemeChangeRoute.dart';
import 'package:flutterStudy/routes/home_page.dart';
import 'package:flutterStudy/routes/language_lage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel,LocaleModel>(
        builder: (context,themeModel,localeModel,child){
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeModel.theme
            ),
            onGenerateTitle: (context){
              return "Git项目";
            },
            home: HomeRoute(),
            locale: localeModel.getLocale(),
            supportedLocales: [
              const Locale('en','US'),
              const Locale('zh','CN')
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (Locale locale,Iterable<Locale> support){
              if(locale!=null){
                return localeModel.getLocale();
              }else{
                Locale locale;
                if(support.contains(locale)){
                  locale=locale;
                }else{
                  locale=Locale('en','US');
                }
                return locale;
              }
            },
            routes: <String,WidgetBuilder>{
              "login":(context)=>LoginRoute(),
              "themes":(context)=>ThemeChangeRoute(),
              "language":(context)=>LanguageRoute(),
              "guest":(context)=>MyAppX()
            },
          );
        },
      ),
    );
  }
}