import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ADBanner extends StatelessWidget {
  final String advertesPicture;
  const ADBanner({Key key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Image.network(advertesPicture),
    );
  }
}
