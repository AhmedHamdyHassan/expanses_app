import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;
  const AdaptiveFlatButton(this.text, this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: FittedBox(
                child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            )))
        : FlatButton(
            onPressed: handler,
            child: FittedBox(
                child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            )));
  }
}
