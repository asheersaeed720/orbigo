import 'package:flutter/material.dart';

import 'package:orbigo/utils/custom_theme.dart';

// MaterialButton longButton(context, String title, Function fun) {
//   return MaterialButton(
//     onPressed: fun,
//     textColor: Colors.white,
//     color: Theme.of(context).primaryColor,
//     child: SizedBox(
//       width: double.infinity,
//       child: Text(
//         title,
//         textAlign: TextAlign.center,
//       ),
//     ),
//     height: 45,
//     minWidth: 600,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(Radius.circular(6)),
//     ),
//   );
// }

Container longButton(context, String title, Function function) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.3,
    child: MaterialButton(
      onPressed: function,
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
      height: 45,
      minWidth: 600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    ),
  );
}

// Container longButton(context, String title, Function auth) {
//   return Container(
//     width: MediaQuery.of(context).size.width / 1.3,
//     decoration: new BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(5.0)),
//       boxShadow: <BoxShadow>[
//         BoxShadow(
//           color: CustomColor.gradientStart,
//           offset: Offset(1.0, 2.0),
//           blurRadius: 4.0,
//         ),
//         BoxShadow(
//           color: CustomColor.gradientEnd,
//           offset: Offset(1.0, 2.0),
//           blurRadius: 4.0,
//         ),
//       ],
//       gradient: new LinearGradient(
//         colors: [
//           CustomColor.gradientEnd,
//           CustomColor.gradientStart,
//         ],
//         begin: const FractionalOffset(0.2, 0.2),
//         end: const FractionalOffset(1.0, 1.0),
//         stops: [0.0, 1.0],
//         tileMode: TileMode.clamp,
//       ),
//     ),
//     child: MaterialButton(
//       highlightColor: Colors.transparent,
//       splashColor: CustomColor.gradientEnd,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 8.0,
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       onPressed: auth,
//     ),
//   );
// }
