import 'package:flutter/material.dart';

class NavbarItemWidget extends StatelessWidget {
  final IconData icon;
  final int count;

  NavbarItemWidget({this.icon, this.count});

  @override
  Widget build(BuildContext context) {
    return new Stack(
          children: <Widget>[
            new Icon(icon),
            new Positioned(
              right: 0,
              child: new Container(
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 15,
                  minHeight: 15,
                ),
                child: new Text(
                  '$count',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
    );
  }
}
