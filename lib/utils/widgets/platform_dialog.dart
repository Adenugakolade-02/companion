import 'dart:io';

import 'package:caution_companion/services/dialog_service.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends StatelessWidget {
  final String? title;
  final Widget content;
  final List<DialogAction> actions;
  const PlatformAlertDialog({super.key, this.title, required this.content, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
      ? AlertDialog(
        title: title != null 
          ? Text(
            title!,
            style: TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900)
          )
          : null,

        content: content,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFFFFFFFF),
        actions: actions.map((e) => TextButton(onPressed: e.onPressed, child: Text(e.text, style: e.textStyle),)).toList(),
      )
      : CupertinoAlertDialog(
        title: title != null 
          ? Text(
            title!,
            style: TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900)
          )
          : null,
        content: content,
        actions: actions.map((e) => CupertinoDialogAction(
            isDefaultAction: e.isDefaultAction,
            onPressed: e.onPressed,
            child: Text(e.text, style: e.textStyle,))).toList(),
      );
  }
}