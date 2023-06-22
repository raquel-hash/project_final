import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:project_final/Place/model/place.dart';
import 'package:project_final/Place/repository/firebase_storage_repository.dart';
import 'package:project_final/Place/ui/widgets/card_image.dart';
import 'package:project_final/User/model/user_firestore.dart';
import 'package:project_final/User/repository/auth_repository.dart';
import 'package:project_final/User/repository/cloud_firestore_api.dart';
import 'package:project_final/User/repository/cloud_firestore_repository.dart';
import 'package:project_final/User/ui/widgets/profile_place.dart';

class UserBloc implements Bloc {
  final _authRepository = AuthRepository();

  //Flujo de daatos - streams
  //stream - Firebase
  //StreamController
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User?> get authStatus => streamFirebase;
  Future<User?> currentUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  //Casos de uso de l aplicacion
  //1. SingIn a la aplicacion Google
  Future<UserCredential> signIn() => _authRepository.signInFirebase();

  // 2.Registrar usuario en BDs
  final _cloudFirestoreRepository = CloudFirestoresRepository();
  void updateUserData(UserFirestore user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);
  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection(CloudFirestoreApi().PLACES)
      .snapshots();
  Stream<QuerySnapshot> get placesStream => placesListStream;

  List<CardImageWithFabIcon> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

  Stream<QuerySnapshot> myPlacesListStream(String uid) => FirebaseFirestore
      .instance
      .collection(CloudFirestoreApi().PLACES)
      .where("userOwner",
          isEqualTo: FirebaseFirestore.instance
              .doc("${CloudFirestoreApi().USERS}/$uid"))
      .snapshots();

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);

  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  signOut() {
    _authRepository.signOut();
  }

  @override
  void dispose() {}
}
