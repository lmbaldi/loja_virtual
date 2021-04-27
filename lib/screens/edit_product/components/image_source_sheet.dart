import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../helpers/helpers.dart';

class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid)
    return BottomSheet(
      onClosing: (){},
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FlatButton(
              onPressed: (){},
              child: Text(R.string.camera),
          ),
          FlatButton(
            onPressed: (){},
            child: Text(R.string.gallery),
          ),

        ],
      ),
    );
    else
      return CupertinoActionSheet(
        title: Text(R.string.msgSelectPhotoCupertino),
        message: Text(R.string.msgChooseSourcePhotoCupertino),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(R.string.cancel),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: (){},
            child: Text(R.string.camera),
          ),
          CupertinoActionSheetAction(
            onPressed: (){},
            child: Text(R.string.gallery),
          ),

        ],

      );
  }
}
