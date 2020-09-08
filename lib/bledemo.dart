// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class BleDemo extends StatelessWidget {


  List<Command> _commands(BuildContext context) {
    return [
      Command(
        title: "one_title",
        subtitle: "one_title_sub",
      ),
      Command(
        title: "two_title",
        subtitle: "two_title_sub",
      ),
      Command(
        title: "three_title",
        subtitle: "three_title_sub",
      ),
      Command(
        title: "placeTanjore",
        subtitle: "placeThanjavurTemple",
      ),
      Command(
        title: "placeTanjore",
        subtitle: "placeThanjavurTemple",
      ),
      Command(
        title: "placePondicherry",
        subtitle: "placeSaltFarm",
      ),
      Command(
        title: "placeChennai",
        subtitle: "placeScooters",
      ),
      Command(
        title: "placeChettinad",
        subtitle: "placeSilkMaker",
      ),
      Command(
        title: "placeChettinad",
        subtitle: "placeLunchPrep",
      ),
      Command(
        title: "placeTanjore",
        subtitle: "placeMarket",
      ),
      Command(
        title: "placePondicherry",
        subtitle: "placeBeach",
      ),
      Command(
        title: "placePondicherry",
        subtitle: "placeFisherman",
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
        crossAxisCount: 2,
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
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        "imgs/timg.jpeg",
        fit: BoxFit.cover,
      ),
    );

    return GestureDetector(
      onTap: ()=>print("def"),
      child: GridTile(
          header: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              title: _GridTitleText(cmd.title),
              backgroundColor: Colors.black45,
            ),
          ),
          child: image
      ),
    );
  }
}

