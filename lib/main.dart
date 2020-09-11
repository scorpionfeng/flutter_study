import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutterStudy/StreamBuildDemo.dart';
import 'package:flutterStudy/sca.dart';
import 'package:flutterStudy/widgets/MyApp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'common/Global.dart';
import 'dock.dart';
import 'gridlist.dart';
import 'devicelist.dart';
import 'FutureBuildDemo.dart';
import 'InheritedWidgetTestRouteState.dart';
import 'provider/ProviderRoute.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((value) => runApp(MyApp()));
}

class MyAppX extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "new_page":(context)=>NewRoute(),
        "random_word":(context)=>RandomWords(),
        "image":(context)=>ImageWidget()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
                FlatButton(child: Text("open new page by dyname way"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new NewRoute();
                  }));}),
                FlatButton(child: Text("switch wiget"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new SwitchDemo();
                  }));}),
                FlatButton(child: Text("future builder"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new FutureBuildDemo();
                  }));}),
                FlatButton(child: Text("inheritedDemo"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new InheritedWidgetTestRoute();
                  }));}),
                FlatButton(child: Text("dock"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new BottomAppBarDemo();
                  }));}),
                FlatButton(child: Text("stream builder"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new StreamBuildDemo();
                  }));}),
                FlatButton(child: Text("tab"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new ScaffoldRoute();
                  }));}),
                FlatButton(child: Text("provider"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new ProviderRoute();
                  }));}),
                FlatButton(child: Text("ble"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new DeviceList();
                  }));}),
                FlatButton(child: Text("flexlayout"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new FlexLayout();
                  }));}),
                FlatButton(child: Text("layout"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new LayoutDemo();
                  }));}),
                FlatButton(child: Text("grid"),textColor: Colors.blue,onPressed: (){
                  Navigator.push(context,new MaterialPageRoute(builder: (context){
                    return new GridListDemo(type:GridListDemoType.imageOnly);
                  }));}),
                FlatButton(onPressed: (){Navigator.pushNamed(context,"new_page");}, child: Text("open from route map"),textColor: Colors.red),
                FlatButton(onPressed: (){Navigator.pushNamed(context,"random_word");}, child: Text("随机数页面"),textColor: Colors.red),
                FlatButton(onPressed: (){Navigator.pushNamed(context,"image");}, child: Text("图片"),textColor: Colors.red)
              ],
            )
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("new Route")),
        body: Center(
          child: Text("this is a new page !!!"),
        ));
  }
}

class RandomWords extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final wordPair=new WordPair.random();
    return Scaffold(
      appBar: AppBar(title: Text("随机数"),),
      body: Center(child: Text(wordPair.toString()),),
    );

  }
}

class ImageWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("图片"),),
      body:Row(children: <Widget>[
         Center(child: Image.asset('imgs/timg.jpeg')),
         Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4")
      ],)
    );
  }
}

class SwitchDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  
    return new _SwitchDemo();
  }
}

class _SwitchDemo extends State<SwitchDemo>{
  bool _switchSelected=true;
  bool _checkboxSelected=true;
  TextEditingController _nameController=new TextEditingController();
  GlobalKey _formkey=new GlobalKey<FormState>();

@override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      print("from controller"+_nameController.text);
    });
    _nameController.selection=TextSelection(
      baseOffset:2,extentOffset:_nameController.text.length
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance.init(context);
    return Scaffold(
      appBar:AppBar(title: Text("switch")),
      body: Column(
      children:<Widget>[
        Switch(value: _switchSelected, onChanged: (bool value) { setState(() {
          _switchSelected=value;
        }); },),
        Checkbox(value: _checkboxSelected,activeColor: Colors.red,onChanged: (value){setState(() {
          _checkboxSelected=value;
        });}),
        TextField(
          autofocus:true,
          controller: _nameController,
          decoration:InputDecoration(labelText:"用户名",hintText:"你的用户名或邮箱",prefixIcon:Icon(Icons.lock)),
        ),
        TextField(
          autofocus:true,
          decoration:InputDecoration(labelText:"密码",hintText:"登陆密码",prefixIcon:Icon(Icons.lock)),
          obscureText:true
        ),
        Form(
          key:_formkey,
          autovalidate: true,
          child: TextFormField(
            controller: _nameController,
          autofocus:true,
          decoration:InputDecoration(labelText:"用户名",hintText:"邮箱",icon:Icon(Icons.email)),
          validator: (v){
            return v.trim().length>0?null:"不能为空";
          },
        ))
      ]
    ),
    );
  }
}

class FlexLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(title:Text("flex layout")),
      body:Column(children: [
        Expanded(child: Container(height: 30.0,color:Colors.red,),
        flex: 1,
        ),
        Expanded(child: Container(height: 30.0,color:Colors.green),
        flex: 2,
        ),
        Padding(padding: const EdgeInsets.only(top:20.0),
        child: SizedBox(height: 100.0,
        child:Flex(direction: Axis.vertical,children: [
          Expanded(child: Container(height: 30.0,color:Colors.red),flex: 2),
          Spacer(flex:1),
          Expanded(child: Container(height: 30.0,color:Colors.green),flex: 1)
        ]),
        )
        )
      ])
    );
  }
}



class  LayoutDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("布局示例")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:<Widget>[
              Text("hello,world"),
              Text("I'm back")
            ]
          ),
          Row(
            children: [Text("Hello"),Text("world")],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}
