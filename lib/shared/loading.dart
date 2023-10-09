import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      backgroundColor: Colors.brown,
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        )
      )
    );
  }
}