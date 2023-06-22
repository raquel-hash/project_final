import 'package:flutter/material.dart';
import 'package:project_final/Place/ui/widgets/review.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Review(
            pathImage: "assets/img/ann.jpg",
            name: "Varuna Yasas",
            details: "1 review . 5 photos",
            comment: "There is an amazing place"),
        Review(
            pathImage: "assets/img/ann.jpg",
            name: "Raquel Quelca",
            details: "2 review . 5 photos",
            comment: "There is an amazing place"),
        Review(
            pathImage: "assets/img/ann.jpg",
            name: "Thomas Marco",
            details: "1 review . 5 photos",
            comment: "There is an amazing place"),
      ],
    );
  }
}
