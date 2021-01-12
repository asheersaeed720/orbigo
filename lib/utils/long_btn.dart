import 'package:flutter/material.dart';

import 'package:orbigo/utils/custom_theme.dart';

Container longButton(context, String title, Function function) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.3,
    child: Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: function,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
          ),
        ),
      ),
    ),
  );
}

// Container longButton(context, String title, Function function) {
//   return Container(
//     width: MediaQuery.of(context).size.width / 1.3,
//     child: MaterialButton(
//       onPressed: function,
//       textColor: Colors.white,
//       color: Theme.of(context).primaryColor,
//       child: SizedBox(
//         width: double.infinity,
//         child: Text(
//           title,
//           textAlign: TextAlign.center,
//         ),
//       ),
//       height: 45,
//       minWidth: 600,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(6)),
//       ),
//     ),
//   );
// }
