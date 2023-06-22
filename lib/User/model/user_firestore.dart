import 'package:flutter/material.dart';
import 'package:project_final/Place/model/place.dart';

class UserFirestore {
  final String uid;
  final String name;
  final String email;
  final String? photoURL;
  final List<Place>? myPlaces;
  final List<Place>? myFavoritePlaces;

  //myFavoritePlaces
  //myPlaces

  UserFirestore(
      {Key? key,
      required this.uid,
      required this.name,
      required this.email,
      required this.photoURL,
      this.myPlaces,
      this.myFavoritePlaces});
}
