import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../../helpers/helpers.dart';

class ImageSourceSheet extends StatelessWidget {

  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  final ImagePicker picker = ImagePicker();
  
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
              onPressed: () async {
                final PickedFile file = await picker.getImage(source: ImageSource.camera);
                 onImageSelected(File(file.path));
              },
              child: Text(R.string.camera),
          ),
          FlatButton(
            onPressed: () async {
              final PickedFile file = await picker.getImage(source: ImageSource.gallery);
              onImageSelected(File(file.path));
            },
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
