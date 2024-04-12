import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeEmergencyWidget extends StatelessWidget {
  const HomeEmergencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: grey400),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container()
            ],
          ),
          const Text("info"),
          const SizedBox(height: 8,),
          const Text("Location"),
          Align(
            alignment: Alignment.centerRight,
            child: Container(),
          )
        ],
      ),
    );
  }
}