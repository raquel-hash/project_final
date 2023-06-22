import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {
  final String? title;
  final double? height;
  const GradientBack({
    Key? key,
    this.title,
    this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidht = MediaQuery.of(context).size.width;

    final double calculatedHeight = height ?? screenHeight;

    return Container(
      width: screenWidht,
      height: calculatedHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4268D3),
            Color(0xFF584CD1),
          ],
          begin: FractionalOffset(0.2, 0.0),
          end: FractionalOffset(1.0, 0.6),
          stops: [0.0, 0.6],
          tileMode: TileMode.clamp,
        ),
      ),
      /*Text(
        title,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: "Lato",
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      ),*/
      child: FittedBox(
        fit: BoxFit.none,
        alignment: const Alignment(-1.5, -0.8),
        child: Container(
          width: screenHeight,
          height: screenHeight,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              borderRadius: BorderRadius.circular(screenHeight / 2)),
        ),
      ),
    );
  }
}
