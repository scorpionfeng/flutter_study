import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterStudy/common/Git.dart';
import 'package:flutterStudy/common/Global.dart';
import 'package:flutterStudy/models/user.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute>{

  TextEditingController _unameController=TextEditingController();
  TextEditingController _pwdController=TextEditingController();
  bool pwdShow=false;
  GlobalKey _formKey=GlobalKey<FormState>();
  bool _nameAutoFocus=true;

  @override
  void initState() {
    _unameController.text=Global.profile.lastLogin;
    if(_unameController.text!=null){
      _nameAutoFocus=false;
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("login"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: _nameAutoFocus,
              controller: _unameController,
              decoration: InputDecoration(
                labelText: "username",
                hintText: "username or email",
                prefixIcon: Icon(Icons.person)
              ),
              validator: (v){
                return v.trim().isNotEmpty? null: "需要用户名";
              },
            ),
            TextFormField(
              autofocus: !_nameAutoFocus,
              controller: _pwdController,
              decoration: InputDecoration(
                labelText: "password",
                hintText: "password ",
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon:Icon(pwdShow?Icons.visibility_off:Icons.visibility),
                  onPressed: (){
                    setState(() {
                      pwdShow=!pwdShow;
                    });
                  },
                )
              ),
              obscureText: !pwdShow,
              validator: (v){
                return v.trim().isNotEmpty?null:"password required";
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top:25),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 55),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: _onLogin,
                  textColor: Colors.white,
                  child:Text("login")
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onLogin() async{
    if((_formKey.currentState as FormState).validate()){
      showLoading();
      User user;
      try{
        user= await Git(context).login(_unameController.text,_pwdController.text);
        Provider.of<UserModel>(context,listen:false).user=user;
      }catch(e){
        if(e.response?.statusCode==401){
          Fluttertoast.showToast(msg: "userName or password wrong");
        }else{
          Fluttertoast.showToast(msg:e.toString());
        }
      }finally{
        Navigator.of(context).pop();
      }
      if(user!=null){
        Navigator.of(context).pop();
      }
    }
  }

  showLoading(){
    showDialog(context: context,
      barrierDismissible: false,
      builder: (context){
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(top:26.0),
              child: Text("正在加载中,请稍后...."),
            )
          ],
        ),
      );
      }
    );
  }
}