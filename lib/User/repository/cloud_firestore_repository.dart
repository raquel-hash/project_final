import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_final/Place/model/place.dart';
import 'package:project_final/Place/ui/widgets/card_image.dart';
import 'package:project_final/User/model/user_firestore.dart';
import 'package:project_final/User/repository/cloud_firestore_api.dart';
import 'package:project_final/User/ui/widgets/profile_place.dart';

class CloudFirestoresRepository {
  final _cloudFirestoreAPI = CloudFirestoreApi();

  void updateUserDataFirestore(UserFirestore user) =>
      _cloudFirestoreAPI.updateUserData(user);
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreAPI.updatePlaceData(place);
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreAPI.buildMyPlaces(placesListSnapshot);
  List<CardImageWithFabIcon> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot) =>
      CloudFirestoreApi().buildPlaces(placesListSnapshot);
}
