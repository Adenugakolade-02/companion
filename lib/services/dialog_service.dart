import 'dart:async';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class DialogService {
  final StreamController<DialogModel> _controller =
      StreamController<DialogModel>();
  
  Stream<DialogModel> get stream => _controller.stream;

  void displayMessage(String message,
      {Status status = Status.failed, String? title}) {
    _controller.add(DialogModel(title: title, message: message, status: status));
  }

  void displayDialog({
    required String title,
    required String message,
    DialogAction? action,
    bool dismissable = true
  }) {
    _controller.add(DialogModel(title: title, message: message, dialogAction: action, dismissable: dismissable, displayType: DisplayType.dialog));
  }


  void dispose() => _controller.close();
}

enum Status { success, failed }

enum DisplayType { snackbar, dialog }

final class DialogAction {
  final String text;
  final void Function()? onPressed;
  final TextStyle? textStyle;
  final bool isDefaultAction;

  DialogAction({
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.isDefaultAction = false,
  });
}

class DialogModel {
  final String? title;
  final String message;
  final DialogAction? dialogAction;
  final NotificationPosition position;
  final Duration duration;
  final DisplayType displayType;
  final Status status;
  final bool dismissable;

  DialogModel(
      {required this.title,
      required this.message,
      this.dialogAction,
      this.position = NotificationPosition.top,
      this.duration = const Duration(seconds: 4),
      this.displayType = DisplayType.snackbar,
      this.status = Status.failed,
      this.dismissable = true});
}
