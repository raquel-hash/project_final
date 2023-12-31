import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:project_final/Place/ui/screens/home_trips.dart';
import 'package:project_final/Place/ui/screens/search_trips.dart';
import 'package:project_final/User/bloc/bloc_user.dart';
import 'package:project_final/User/ui/screens/profile_trips.dart';
import 'package:project_final/setting_screen.dart';

class TripsCupertino extends StatelessWidget {
  const TripsCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.indigo), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.indigo), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.indigo), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.indigo), label: ""),
        ]),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) => const HomeTrips(),
              );
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) => const SearchTrips(),
              );
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return BlocProvider(
                      bloc: UserBloc(), child: const ProfileTrips());
                },
              );
            case 3:
              return CupertinoTabView(
                builder: (BuildContext context) => const SettingScreen(),
              );
            default:
              return CupertinoTabView(
                builder: (BuildContext context) =>
                    const Text('Invalid index value'),
              );
          }
        },
      ),
    );
  }
}
