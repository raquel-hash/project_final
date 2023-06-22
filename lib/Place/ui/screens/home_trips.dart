import 'package:flutter/material.dart';
import 'package:project_final/Place/ui/widgets/review_list.dart';

import '../widgets/description_place.dart';
import 'header_appbar.dart';

class HomeTrips extends StatelessWidget {
  const HomeTrips({super.key});

  @override
  Widget build(BuildContext context) {
    String descriptionDummy =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. \n\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
    return Stack(
      children: [
        ListView(
          children: [
            DescriptionPlace(
              namePlace: "Bahamas",
              stars: 4,
              descriptionPlace: descriptionDummy,
            ),
            const ReviewList(),
          ],
        ),
        const HeaderAppBar(),
      ],
    );
  }
}
