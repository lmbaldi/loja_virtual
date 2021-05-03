import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../screens.dart';

class AddTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void onImageSelected(File file){

    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: (){
          if (Platform.isAndroid)
            showModalBottomSheet(
                context: context,
                builder: (_) => ImageSourceSheet(
                  onImageSelected: onImageSelected,
                ));
          else
            showCupertinoModalPopup(
                context: context,
                builder: (_) => ImageSourceSheet(
                  onImageSelected: onImageSelected,
                ));
        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child:  Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
