import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../helpers/helpers.dart';

class ImageSourceSheet extends StatelessWidget {

  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  final ImagePicker picker = ImagePicker();

  Future<void> editImage(String path, BuildContext context) async {
     final File croppedFile =  await ImageCropper.cropImage(
      sourcePath: path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: R.string.editImage,
        toolbarColor: Theme.of(context).primaryColor,
        toolbarWidgetColor: Colors.white
      ),
      iosUiSettings: IOSUiSettings(
        title: R.string.editImage,
        cancelButtonTitle: R.string.cancel,
        doneButtonTitle: R.string.conclude
      )
    );
     if(croppedFile != null){
       onImageSelected(croppedFile);
     }
  }

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
                 editImage(file?.path, context);
              },
              child: Text(R.string.camera),
          ),
          FlatButton(
            onPressed: () async {
              final PickedFile file = await picker.getImage(source: ImageSource.gallery);
              editImage(file.path, context);
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
            onPressed: () async {
              final PickedFile file = await picker.getImage(source: ImageSource.camera);
              editImage(file.path, context);
            },
            child: Text(R.string.camera),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final PickedFile file = await picker.getImage(source: ImageSource.camera);
              editImage(file.path, context);
            },
            child: Text(R.string.gallery),
          ),
        ],
      );
  }
}
