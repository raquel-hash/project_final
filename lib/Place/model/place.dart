import 'package:flutter/material.dart';
import 'package:project_final/User/model/user_firestore.dart';

class Place {
  String? id;
  String name;
  String description;
  String urlImage;
  int? likes;
  // UserFirestore? userOwner;

  Place({
    Key? key,
    required this.name,
    required this.description,
    required this.urlImage,
    this.likes,
    // this.userOwner
  });
}
