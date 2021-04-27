import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/helpers.dart';

class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  }
}
