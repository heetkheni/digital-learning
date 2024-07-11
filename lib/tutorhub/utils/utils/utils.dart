// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class Utils {

//  void toast(String message){
//   Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
// }
//    void fieldFocus(BuildContext context , FocusNode focusNode , FocusNode nextNode){
    
//     focusNode.unfocus();
//     FocusScope.of(context).requestFocus(nextNode);
//   }

//   void dialogue(BuildContext context) async{
    
//         await showDialog<bool>(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Do you want to go back?'),
//               actionsAlignment: MainAxisAlignment.spaceBetween,
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, true);
//                   },
//                   child: const Text('Yes'),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, false);
//                   },
//                   child: const Text('No'),
//                 ),
//               ],
//             );
//           },
//         );
      
//   }

// }