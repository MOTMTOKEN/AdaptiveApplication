import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final Key key;
  final String text;
  final Function _onPressed;


  AdaptiveButton(this.key,this.text, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS? CupertinoButton(
      key: key,
      padding: const EdgeInsets.all(10),
      child: Text(text),
      onPressed: _onPressed,
    ): RaisedButton(
      key: key,
    padding: const EdgeInsets.all(10),
    child: Text(text),
    onPressed: _onPressed,
    ) ;
  }
}
