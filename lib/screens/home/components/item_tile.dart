import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../data/data.dart';

class ItemTile extends StatelessWidget {
  final SectionItem item;

  ItemTile(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductManager>().findProductById(item.product);
          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String
          ? FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: item.image,
              fit: BoxFit.cover,
            )
          : Image.file(item.image as File, fit: BoxFit.cover,),
      ),
    );
  }
}
