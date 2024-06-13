import 'package:caution_companion/locator.dart';
import 'package:caution_companion/services/dialog_service.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/widgets/custom_snackbar.dart';
import 'package:caution_companion/utils/widgets/platform_dialog.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class AppAware extends StatefulWidget {
  final Widget child;
  const AppAware({super.key, required this.child});

  @override
  State<AppAware> createState() => _AppAwareState();
}

class _AppAwareState extends State<AppAware> {
  OverlaySupportEntry? _snackBarEntry;
  OverlaySupportEntry? _dialogEntry;
  final DialogService dialog = serviceLocator<DialogService>();

  @override
  void initState() {
    super.initState();
    dialog.stream.listen((event) {
      switch(event.displayType){
        case DisplayType.snackbar:
          _snackBarEntry?.dismiss();
          _snackBarEntry = showOverlayNotification(
            position: event.position,
            duration: event.duration,
            (context) {
            return CustomSnackBar(
              title: event.title,
              message: event.message, 
              background: event.status==Status.success?Colors.green:error400, onDismiss: _snackBarEntry!.dismiss);
          });
        case DisplayType.dialog:
          _dialogEntry?.dismiss();
          _dialogEntry = showOverlay(
            duration: Duration.zero,
            (context,_){
            return Material(
              color: Colors.black38,
              child: PlatformAlertDialog(
                title: event.title,
                content: Text(event.message, style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey900),),
                actions: [
                  if(event.dismissable)
                    DialogAction(text: "CLOSE", onPressed: ()=>_dialogEntry!.dismiss(), textStyle: TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w600, color: error400)),

                  if(event.dialogAction != null)
                    DialogAction(text: event.dialogAction!.text, onPressed: event.dialogAction!.onPressed, textStyle: TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w600, color: warning400))
                ],
              ),
            );
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(child: widget.child);
  }
}