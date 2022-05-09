import 'package:flutter/material.dart';

import '../main.dart';
import '../shared/widgets/util/custom_button.dart';

/// Service for some util shit
class UtilService{

  /// Displays a success for 3 seconds
  /// Needs:
  ///  - String title: Title of the box
  ///  - String message: Message of the box
  static void showSuccess(String title, String? message){
    message ??= '';
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          
          return AlertDialog(
            title: Text(title),
            content: Column(
              children: [
                Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                ),
                Text(message!),
              ],
            ),
          );
        });
  }

  /// Displays a error until the user clicks ok
  /// Needs:
  ///  - String title: Title of the box
  ///  - String message: Message of the box
  static void showError(String title, String? message){
    message ??= '';
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: Text(title, textAlign: TextAlign.center,),
            actions: [
              CustomButton(
                onTap: (){
                  Navigator.pop(context);
                },
                text: 'Ok',
                isDanger: true,
              ),
              const SizedBox(height: 16.0,),
            ],
            actionsAlignment: MainAxisAlignment.spaceAround,
            actionsPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.clear,
                  color: Theme.of(context).errorColor,
                  size: 100.0,
                ),
                Text(message!, textAlign: TextAlign.center,),
              ],
            ),
          );
        });
  }

  static void unknownError(){
    UtilService.showError(
        'Unknown Error',
        'A error accrued'
    );
  }
}