import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final function;

  PlusButton({this.function});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: function,
      color: Colors.black45,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            'A D D',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // RaisedButton(
  //     child: Container(
  //       margin: EdgeInsets.fromLTRB(6, 20, 6, 20),
  //       //padding: EdgeInsets.all(20),
  //       child: Text(
  //         name,
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white70,
  //           fontSize: 16,
  //         ),
  //       ),
  //     ),
  //     onPressed: () {
  //       function(getItemList());
  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
  //     color: Colors.black45,
  //     elevation: 16,
  //   );
}
