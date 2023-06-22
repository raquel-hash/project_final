import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_final/widgets/floating_action_button_green.dart';

class CardImageWithFabIcon extends StatelessWidget {
  final double height;
  final double width;
  final double left;
  final String pathImage;
  final VoidCallback onPressedFabIcon;
  final IconData icon;
  const CardImageWithFabIcon({
    Key? key,
    required this.height,
    required this.width,
    required this.left,
    required this.pathImage,
    required this.onPressedFabIcon,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
        left: left,
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(pathImage),
            // image: pathImage.contains('assets')
            //     ? NetworkImage(pathImage)
            //     : FileImage(File(pathImage)) as ImageProvider<Object>,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          boxShadow: const [
            BoxShadow(
                color: Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0, 7.0)),
          ]),
    );
    return Stack(alignment: const Alignment(0.9, 1.1), children: <Widget>[
      card,
      FloatingActionButtonGreen(
        icon: icon,
        onPressed: onPressedFabIcon,
      )
    ]);
  }
}
