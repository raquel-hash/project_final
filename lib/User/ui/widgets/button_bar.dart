import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_final/Place/ui/screens/add_place.dart';
import 'package:project_final/User/bloc/bloc_user.dart';

import 'circle_button.dart';

class ButtonsBar extends StatelessWidget {
  const ButtonsBar({super.key});

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: [
            CircleButton(
                mini: true,
                icon: Icons.vpn_key,
                iconSize: 20.0,
                color: const Color.fromRGBO(255, 255, 255, 0.6),
                onPressed: () => {}),
            CircleButton(
              mini: false,
              icon: Icons.add,
              iconSize: 40.0,
              color: const Color.fromRGBO(255, 255, 255, 1),
              onPressed: () {
                ImagePicker.platform
                    .pickImage(source: ImageSource.camera)
                    .then((PickedFile? pickedFile) {
                  if (pickedFile != null) {
                    File image = File(pickedFile.path);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddPlace(image: image),
                      ),
                    );
                  }
                }).catchError((onError) => print(onError));
              },
            ),
            CircleButton(
              mini: true,
              icon: Icons.exit_to_app,
              iconSize: 20.0,
              color: const Color.fromRGBO(255, 255, 255, 0.6),
              onPressed: () => {userBloc.signOut()},
            ),
          ],
        ));
  }
}
