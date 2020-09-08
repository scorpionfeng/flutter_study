// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:developer';
enum GridListDemoType {
  imageOnly,
  header,
  footer,
}

class GridListDemo extends StatelessWidget {
  const GridListDemo({Key key, this.type}) : super(key: key);

  final GridListDemoType type;

  List<_Photo> _photos(BuildContext context) {
    return [
      _Photo(
        assetName: 'imgs/india_chennai_flower_market.png',
        title: "one_title",
        subtitle: "one_title_sub",
      ),
      _Photo(
        assetName: 'imgs/india_tanjore_bronze_works.png',
        title: "two_title",
        subtitle: "two_title_sub",
      ),
      _Photo(
        assetName: 'imgs/india_tanjore_market_merchant.png',
        title: "three_title",
        subtitle: "three_title_sub",
      ),
      _Photo(
        assetName: 'imgs/india_tanjore_thanjavur_temple.png',
        title: "placeTanjore",
        subtitle: "placeThanjavurTemple",
      ),
      _Photo(
        assetName: 'imgs/india_tanjore_thanjavur_temple_carvings.png',
        title: "placeTanjore",
        subtitle: "placeThanjavurTemple",
      ),
      _Photo(
        assetName: 'imgs/india_pondicherry_salt_farm.png',
        title: "placePondicherry",
        subtitle: "placeSaltFarm",
      ),
      _Photo(
        assetName: 'imgs/india_chennai_highway.png',
        title: "placeChennai",
        subtitle: "placeScooters",
      ),
      _Photo(
        assetName: 'imgs/india_chettinad_silk_maker.png',
        title: "placeChettinad",
        subtitle: "placeSilkMaker",
      ),
      _Photo(
        assetName: 'imgs/india_chettinad_produce.png',
        title: "placeChettinad",
        subtitle: "placeLunchPrep",
      ),
      _Photo(
        assetName: 'imgs/india_tanjore_market_technology.png',
        title: "placeTanjore",
        subtitle: "placeMarket",
      ),
      _Photo(
        assetName: 'imgs/india_pondicherry_beach.png',
        title: "placePondicherry",
        subtitle: "placeBeach",
      ),
      _Photo(
        assetName: 'imgs/india_pondicherry_fisherman.png',
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
        title: Text("demoGridListsTitle"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: _photos(context).map<Widget>((photo) {
          print("photo is "+photo.toString());

          return  _GridDemoPhotoItem(
            photo: photo,
            tileStyle: type,
          );
        }).toList(),
      ),
    );
  }
}

class _Photo {
  _Photo({
    this.assetName,
    this.title,
    this.subtitle,
  });

  final String assetName;
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
    @required this.photo,
    @required this.tileStyle,
  }) : super(key: key);

  final _Photo photo;
  final GridListDemoType tileStyle;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        photo.assetName,
        fit: BoxFit.cover,
      ),
    );

    switch (tileStyle) {
      case GridListDemoType.imageOnly:
        return image;
      case GridListDemoType.header:
        return GridTile(
          header: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              title: _GridTitleText(photo.title),
              backgroundColor: Colors.black45,
            ),
          ),
          child: image,
        );
      case GridListDemoType.footer:
        return GridTile(
          footer: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              backgroundColor: Colors.black45,
              title: _GridTitleText(photo.title),
              subtitle: _GridTitleText(photo.subtitle),
            ),
          ),
          child: image,
        );
    }
    return null;
  }
}

