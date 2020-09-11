import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterStudy/common/Git.dart';
import 'package:flutterStudy/common/Global.dart';
import 'package:flutterStudy/models/repo.dart';
import 'package:flutterStudy/widgets/MyDrawer.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("实战"),),
      body: _buildBody(),
      drawer: MyDrawer(),
    );
  }
  
  Widget _buildBody(){
    UserModel userModel=Provider.of<UserModel>(context);
    if(!userModel.isLogin){
      return Center(
        child: RaisedButton(
          child: Text("login"),
          onPressed: ()=>Navigator.of(context).pushNamed("login"),
        ),
      );
    }else{
      return InfiniteListView<Repo>(
        onRetrieveData: (int page,List<Repo> items,bool refresh) async{
          var data= await Git(context).getRepos(
            refresh:refresh,
              queryParameters:{
              'page':page,
                'page_size':20,
              }
          );
          items.addAll(data);
          return data.length==20;
        },
        itemBuilder: (List list,int index,BuildContext ctx){
          return RepoItem(list[index]);
        },
      );
    }
  }
}

class RepoItem extends StatefulWidget{
  RepoItem(this.repo):super(key:ValueKey(repo.id));
  final Repo repo;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RepoItemState();
  }
}

class _RepoItemState extends State<RepoItem>{
  @override
  Widget build(BuildContext context) {
    var subtitle;
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Material(
        color: Colors.blue,
        shape:BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5
          )
        ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
          dense: true,
        leading: gmAvatar(
          widget.repo.owner.avatar_url,
          width:24.0,
          borderRadius:BorderRadius.circular(12)
        ),
        title: Text(
          widget.repo.owner.login,
          textScaleFactor: .9,
        ),
        subtitle: subtitle,
        trailing: Text(widget.repo.language?? ""),
      ),
          Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 12.0),
            child: widget.repo.description==null?Text("noDescription", style: TextStyle(
              fontStyle: FontStyle.italic,color: Colors.grey[700]
            )):Text(widget.repo.description,maxLines: 3,style: TextStyle(
              height: 1.15,color:Colors.blueGrey[700],fontSize: 13
            ),)
          ),
          _buildBottom()
        ],
      ),
      ),
    );
  }

  Widget _buildBottom(){
    const paddingWidth=10;
    return IconTheme(
      data:IconThemeData(
        color:Colors.grey,
        size:15
      ),
      child: DefaultTextStyle(
        style: TextStyle(color:Colors.grey,fontSize: 12),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6),child: Builder(builder: (context){
          var children=<Widget>[
            Icon(Icons.star),
            Text(""+widget.repo.stargazers_count.toString().padRight(paddingWidth)),
            Icon(Icons.info_outline),
            Text(""+widget.repo.open_issues_count.toString().padRight(paddingWidth)),
            Icon(Icons.mouse),
            Text(widget.repo.forks_count.toString().padRight(paddingWidth))
          ];
          if(widget.repo.fork){
            children.add(Text("forkded".padRight(paddingWidth)));
          }
          if(widget.repo.private==true){
            children.addAll(<Widget>[
              Icon(Icons.lock),
              Text("private ".padRight(paddingWidth))
            ]);
          }
          return Row(children: children);
        },),),
      ),
    );
  }

  Widget gmAvatar(String url,{
    double width=30,
    double height,
    BoxFit fit,
    BorderRadius borderRadius,
}){
    var placeholder=Image.asset("imgs/avatar-default.png",width: width,height: height);
    return ClipRRect(
      borderRadius: borderRadius??BorderRadius.circular(2),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context,url)=>placeholder,
        errorWidget: (context,url,error)=>placeholder,
      ),
    );
  }
}