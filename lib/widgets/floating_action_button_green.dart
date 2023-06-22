import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const FloatingActionButtonGreen({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<FloatingActionButtonGreen> createState() =>
      _FloatingActionButtonGreen();
}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {
  // void onPressedFav() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Agregaste a tus favoritos")));
  // }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: widget.onPressed,
      heroTag: null,
      child: Icon(widget.icon),
    );
  }
}
