import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:project_final/User/bloc/bloc_user.dart';
import 'package:project_final/User/model/user_firestore.dart';
import 'package:project_final/User/ui/screens/profile_header.dart';
import 'package:project_final/User/ui/widgets/button_bar.dart';
import 'package:project_final/User/ui/widgets/profile_background.dart';
import 'package:project_final/User/ui/widgets/profile_places_list.dart';
import 'package:project_final/User/ui/widgets/user_info.dart';

class ProfileTrips extends StatelessWidget {
  const ProfileTrips({super.key});

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of(context);
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          case ConnectionState.none:
            return const CircularProgressIndicator();
          case ConnectionState.active:
            return showProfileData(snapshot);
          case ConnectionState.done:
            return showProfileData(snapshot);
          default:
            return showProfileData(snapshot);
        }
      },
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData && snapshot.hasError) {
      print("No logueado");
      return Stack(
        children: <Widget>[
          const ProfileBackground(),
          ListView(children: [
            Container(
              child: Text('Usuario no logueado. Haz login'),
            )
          ]),
        ],
      );
    } else {
      print("Logueado");
      print(snapshot.data);
      var user = UserFirestore(
        uid: snapshot.data.uid,
        name: snapshot.data.displayName,
        email: snapshot.data.email,
        photoURL: snapshot.data.photoURL,
      );
      return Stack(
        children: <Widget>[
          const ProfileBackground(),
          ListView(children: [
            ProfileHeader(
              user: user,
            ),
            ProfilePlacesList(
              user: user,
            ),
          ]),
        ],
      );
    }
  }
}
