import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../../../data/data.dart';
import 'components.dart';

class ImagesForm extends StatelessWidget {
  final Product product;

  ImagesForm(this.product);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return FormField<List<dynamic>>(
      initialValue: product.images,
      builder: (state) {
        return AspectRatio(
          aspectRatio: 1.2,
          child: Carousel(
            images: state.value.map<Widget>((image) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  if(image is String)
                    Image.network(image, fit: BoxFit.cover)
                  else
                    Image.file(image as File, fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                      onPressed: (){
                        state.value.remove(image);
                        state.didChange(state.value);
                      },
                    ),
                  )
                ],
              );
            }).toList()..add(
              Material(
                color: Colors.grey[200],
                child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    color: primaryColor,
                    iconSize: 50,
                    onPressed: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (_) => ImageSourceSheet()
                      );
                    }
                ),
              )
            ),
            dotSize: 4,
            dotSpacing: 15,
            dotBgColor: Colors.transparent,
            dotColor: primaryColor,
            autoplay: false,
          ),
        );
      },
    );
  }
}
