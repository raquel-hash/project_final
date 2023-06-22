import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:project_final/User/bloc/bloc_user.dart';
import 'package:project_final/User/model/user_firestore.dart';
import 'package:project_final/trips_cupertino.dart';
import 'package:project_final/widgets/button_green.dart';
import 'package:project_final/widgets/gradient_back.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return _handleCurrentSesion();
  }

  Widget _handleCurrentSesion() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          print(snapshot.hasData);
          return signInGoogleUI();
        } else {
          return const TripsCupertino();
        }
      },
    );
  }

  Widget signInGoogleUI() {
    final double screenWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        const GradientBack(height: null),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SizedBox(
                width: screenWidht,
                child: const Text(
                  "Bienvenido \n Esta es tu App de Viajes",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 37.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ButtonGreen(
                text: "Iniciar sesión con Gmail",
                onPressed: () => {
                      userBloc.signOut(),
                      userBloc.signIn().then((UserCredential userCredential) {
                        User? user = userCredential.user;
                        if (user != null) {
                          userBloc.updateUserData(UserFirestore(
                              uid: user.uid,
                              name: user.displayName ?? '',
                              email: user.email ?? '',
                              photoURL: user.photoURL));
                        }
                      })
                    },
                width: 300.0,
                height: 50.0)
          ],
        ),
      ]),
    );
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    // return Container(
    //   width: width,
    //   height: height,
    //   decoration: const BoxDecoration(
    //       color: Colors.white,
    //       image: DecorationImage(
    //           image: AssetImage('assets/img/sunset.jpeg'),
    //           alignment: Alignment.center,
    //           fit: BoxFit.cover)),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Text(
    //         "Bienvenido",
    //         style: TextStyle(
    //             fontSize: 32.0,
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold),
    //       ),
    //       Text(
    //         "Explore una nueva experiencia",
    //         style: TextStyle(
    //             fontSize: 18,
    //             color: Color(0xFF424242),
    //             fontWeight: FontWeight.bold),
    //       ),
    //       Container(
    //         width: width * 0.8,
    //         height: height * 0.07,
    //         decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2)),
    //       )
    //     ],
    //   ),
    // );
  }
}
