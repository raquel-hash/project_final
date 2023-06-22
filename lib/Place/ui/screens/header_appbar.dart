import 'package:flutter/material.dart';
import 'package:project_final/Place/ui/widgets/card_image_list.dart';
import 'package:project_final/widgets/gradient_back.dart';

class HeaderAppBar extends StatelessWidget {
  const HeaderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        GradientBack(
          height: 250.0,
        ),
        CardImageList(),
      ],
    );
  }
}
