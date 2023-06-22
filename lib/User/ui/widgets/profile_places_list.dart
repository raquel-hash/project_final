import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:project_final/Place/model/place.dart';
import 'package:project_final/User/bloc/bloc_user.dart';
import 'package:project_final/User/model/user_firestore.dart';
import 'package:project_final/User/ui/widgets/profile_place.dart';

class ProfilePlacesList extends StatelessWidget {
  final UserFirestore user;

  const ProfilePlacesList({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    Place place = Place(
        name: "Knuckles Mountains Range",
        description: "Hiking. Water fall hunting. Natural bath",
        urlImage:
            "https://images.unsplash.com/photo-1519681393784-d120267933ba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
        likes: 3);
    Place place2 = Place(
        name: "Mountains",
        description:
            "Hiking. Water fall hunting. Natural bath', 'Scenery & Photography",
        urlImage:
            "https://images.unsplash.com/photo-1524654458049-e36be0721fa2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
        likes: 10);

    return Container(
      margin: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: StreamBuilder(
          stream: userBloc.myPlacesListStream(user.uid),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data.docs != null) {
              return Column(
                children: userBloc.buildMyPlaces(snapshot.data.docs),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
  /*
  * Column(
        children: <Widget>[
          ProfilePlace(place: place),
          ProfilePlace(place: place2),
        ],
      ),
  */
}
