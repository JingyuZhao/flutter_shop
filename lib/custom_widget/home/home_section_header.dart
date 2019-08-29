import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String picture_address;
  const SectionHeader({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.transparent,
      child: Image.network(
        picture_address,
        fit: BoxFit.fill,
      ),
    );
  }
}
