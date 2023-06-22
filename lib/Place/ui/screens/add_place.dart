import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:project_final/Place/model/place.dart';
import 'package:project_final/Place/ui/widgets/card_image.dart';
import 'package:project_final/Place/ui/widgets/text_input_location.dart';
import 'package:project_final/User/bloc/bloc_user.dart';
import 'package:project_final/widgets/button_purple.dart';
import 'package:project_final/widgets/gradient_back.dart';
import 'package:project_final/widgets/text_input.dart';
import 'package:project_final/widgets/title_header.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AddPlace extends StatefulWidget {
  final File image;
  const AddPlace({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  @override
  Widget build(BuildContext context) {
    UserBloc userBLoc = BlocProvider.of(context);
    final double screenWidht = MediaQuery.of(context).size.width;
    final controllerTitlePlace = TextEditingController();
    final controllerDescriptionPlace = TextEditingController();
    final controllerLocationPlace = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          const GradientBack(
            height: 300.0,
          ),
          Row(
            //AppBAr
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 25.0,
                  left: 5.0,
                ),
                child: SizedBox(
                  height: 45.0,
                  width: 45.0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 45,
                    ),
                    onPressed: () => {Navigator.pop(context)},
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  width: screenWidht,
                  padding: const EdgeInsets.only(
                    top: 45.0,
                    left: 20.0,
                    right: 10.0,
                  ),
                  child: const TitleHeader(title: "Agregar un nuevo lugar"),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 120.0,
              bottom: 20.0,
            ),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CardImageWithFabIcon(
                    height: 250.0,
                    width: 350.0,
                    left: 20.0,
                    pathImage: widget.image.path,
                    onPressedFabIcon: () {},
                    icon: Icons.camera_alt,
                  ),
                ), //Foto
                Container(
                  margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TextInput(
                    hintText: "Titulo",
                    inputType: TextInputType.text,
                    controller: controllerTitlePlace,
                    maxLines: 1,
                  ),
                ),
                TextInput(
                  hintText: "Descripcion",
                  inputType: TextInputType.multiline,
                  controller: controllerDescriptionPlace,
                  maxLines: 4,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: TextInputLocation(
                    controller: controllerLocationPlace,
                    hintText: "Agregar unicacion",
                    icon: Icons.location_on,
                  ),
                ),
                SizedBox(
                  width: 70.0,
                  child: ButtonPurple(
                    buttonText: "Agregar lugar",
                    onpressed: () {
                      //ID del usaurio logueado actualmente
                      userBLoc.currentUsuario().then(
                        (User? user) {
                          if (user != null) {
                            String uid = user.uid;
                            String path =
                                "$uid/${DateTime.now().toString()}.jpg";
                            //1. Firebase Storage
                            //url -
                            userBLoc
                                .uploadFile(path, widget.image)
                                .then((UploadTask storageUploadTask) {
                              storageUploadTask.then((TaskSnapshot snapshot) {
                                snapshot.ref.getDownloadURL().then((urlImage) {
                                  print('URL IMAGE:{$urlImage}');
                                  //2. Cloud Firestore
                                  userBLoc
                                      .updatePlaceData(
                                    Place(
                                      name: controllerTitlePlace.text,
                                      description:
                                          controllerDescriptionPlace.text,
                                      urlImage: urlImage,
                                      likes: 0,
                                    ),
                                  )
                                      .whenComplete(() {
                                    print("Termino");
                                    Navigator.pop(context);
                                  });
                                });
                              });
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
