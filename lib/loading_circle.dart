import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SpinKitFadingCircle(
          color: Colors.black45,
          size: 50.0,
        ),
        // child: CupertinoActivityIndicator(
        //   radius: 16.0,
        // ),
        // child: LoadingBouncingGrid.circle(
        //   backgroundColor: Colors.black45,
        //),
      ),
    );
  }
}
