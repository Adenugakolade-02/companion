import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String? title;
  final String message;
  final Color background;
  final void Function() onDismiss;
  const CustomSnackBar({super.key, this.title, required this.message, required this.background, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTapDown: (_) => onDismiss(),
        child: Container(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
           width: size.width,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(5)),
            color: background,
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(title != null) ...[
                  Text(title!, style: const TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w600, color: Colors.white),),
                  const SizedBox(height: 10,)
                ],
                Text(message, style: const TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: Colors.white),)
              ],
            )
          ),
        ),
      ),
    );
  }
}