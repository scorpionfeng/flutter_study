// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutterStudy/bledemo.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Device {
  Device({this.title, this.subtitle});
  final String title;
  final String subtitle;
}

class DeviceList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DeviceState();
  }
}

class DeviceState extends State<DeviceList> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  void initState() {
    super.initState();

    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        if (r.device.name == "AD10") {
          setState(() {
            _devices.add(Device(title: r.device.name, subtitle: r.device.name));
          });
        }
      }
    });
  }

  var _devices = new Set<Device>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("蓝牙设备列表"),
      ),
      body: Scrollbar(
        child: Column(
          children: [
            FlatButton(
              child: Text("搜索"),
              onPressed: () =>
                  {flutterBlue.startScan(timeout: Duration(seconds: 4))},
            ),
            FlatButton(
              child: Text("停止"),
              onPressed: () => {flutterBlue.stopScan()},
            ),
            FlatButton(
              child: Text("testAdd"),
              onPressed: () =>
                setState(()=>{
                  _devices.add(Device(title: "test",subtitle: "test"))
                }),
            ),
            Expanded(child:ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: _devices
                    .map<Widget>(
                      (device) => GestureDetector(child: ListTile(
                        leading: ExcludeSemantics(
                          child: CircleAvatar(child: Text(device.title)),
                        ),
                      ),
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context){
                        return BleDemo();
                      }))),
                )
                    .toList())
              ,)
          ],
        ),
      ),
    );
  }
}
