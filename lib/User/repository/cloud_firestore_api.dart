import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_final/Place/ui/widgets/card_image.dart';
import 'package:project_final/User/model/user_firestore.dart';
import 'package:project_final/User/ui/widgets/profile_place.dart';

import '../../Place/model/place.dart';

class CloudFirestoreApi {
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(UserFirestore user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference ref = _db.collection(PLACES);
    User? user = _auth.currentUser;
    if (user != null) {
      ref.add({
        'name': place.name,
        'description': place.description,
        'likes': place.likes,
        'urlImage': place.urlImage,
        'userOwner': _db.doc("$USERS/${user.uid}"), // reference
      }).then((DocumentReference dr) {
        dr.get().then((DocumentSnapshot snapshot) {
          snapshot.id;
          DocumentReference refUsers = _db.collection(USERS).doc(user.uid);
          refUsers.update({
            'myPlaces':
                FieldValue.arrayUnion([_db.doc("$PLACES/${snapshot.id}")])
          });
        });
      });
    }
  }

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = [];
    for (var p in placesListSnapshot) {
      profilePlaces.add(ProfilePlace(
          place: Place(
        name: p['name'],
        description: p['description'],
        urlImage: p['urlImage'],
        likes: p["likes"],
      )));
    }
    return profilePlaces;
  }

  List<CardImageWithFabIcon> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot) {
    List<CardImageWithFabIcon> placesCard = [];
    double width = 300.0;
    double height = 350.0;
    double left = 20.0;
    IconData icon = Icons.favorite_border;
    for (var p in placesListSnapshot) {
      placesCard.add(
        CardImageWithFabIcon(
          height: height,
          width: width,
          left: left,
          pathImage: p["urlImage"],
          onPressedFabIcon: () {
            LikePlace(p.id);
          },
          icon: icon,
        ),
      );
    }
    return placesCard;
  }

  Future LikePlace(String idPlace) async {
    await _db.collection(PLACES).doc(idPlace).get().then((DocumentSnapshot ds) {
      int likes = ds["likes"];
      _db.collection(PLACES).doc(idPlace).update({
        'likes': likes + 1,
      });
    });
  }
}
