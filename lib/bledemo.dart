// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class BleDemo extends StatelessWidget {


  List<Command> _commands(BuildContext context) {
    return [
      Command(
        title: "搜索",
        subtitle: "搜索ad10",
      ),
      Command(
        title: "配置",
        subtitle: "扫描",
      ),
      Command(
        title: "数据流",
        subtitle: "数据流支持项",
      ),
      Command(
        title: "转速",
        subtitle: "发动机转速",
      ),
      Command(
        title: "电压",
        subtitle: "设备电压",
      ),
      Command(
        title: "boxinfo",
        subtitle: "设备信息",
      ),
      Command(
        title: "vin码",
        subtitle: "发动机vin码",
      ),
      Command(
        title: "故障灯",
        subtitle: "故障灯和就绪状态",
      ),
      Command(
        title: "冻结帧",
        subtitle: "冻结帧列表",
      ),
      Command(
        title: "车速",
        subtitle: "冻结帧的车速",
      ),
      Command(
        title: "initBin",
        subtitle: "初始化bin文件",
      ),
      Command(
        title: "烧录",
        subtitle: "开始烧录",
      ),
      Command(
        title: "canstd",
        subtitle: "标准can进入",
      ),
      Command(
        title: "canext",
        subtitle: "扩展can进入",
      ),
      Command(
        title: "iso",
        subtitle: "ISO协议进入",
      ),
      Command(
        title: "kwp",
        subtitle: "KWP进入",
      ),
      Command(
        title: "PWM",
        subtitle: "PWM协议进入",
      ),
      Command(
        title: "VPW",
        subtitle: "VPW协议进入",
      ),
      Command(
        title: "故障码",
        subtitle: "故障码",
      ),
      Command(
        title: "清码",
        subtitle: "清码",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("ble"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: _commands(context).map<Widget>((cmd) {
          print("photo is "+cmd.toString());

          return  _GridDemoPhotoItem(
            cmd: cmd,
          );
        }).toList(),
      ),
    );
  }
}

class Command {
  Command({
    this.title,
    this.subtitle,
  });

  final String title;
  final String subtitle;
}

/// Allow the text size to shrink to fit in the space
class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}

class _GridDemoPhotoItem extends StatelessWidget {
  _GridDemoPhotoItem({
    Key key,
    @required this.cmd,
  }) : super(key: key);

  final Command cmd;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: ()=>print("def"),
      child: Center(child: Text(cmd.title))
    );
  }
}

