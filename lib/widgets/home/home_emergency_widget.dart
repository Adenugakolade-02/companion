import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeEmergencyWidget extends StatelessWidget {
  const HomeEmergencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        border: Border.all(color: grey400),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/images/bell.svg"),
              const SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NEW REPORT", style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey500),),
                  const SizedBox(height: 4,),
                  Text("Robbery", style: TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),)
                ],
              ),
              const Spacer(),
              Text("3 hours ago ", style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400, color: warning400),)
            ],
          ),
          const SizedBox(height: 16,),
          
          Text("Info: There’s a robbery going on at banking area, you may want to avoid the area", style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey900),),
          
          const SizedBox(height: 8,),
          
          Text("Location: Lagere, Ile-Ife.", style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey900),),

          const Spacer(),

          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 17,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero
                ),
                onPressed: (){}, 
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "View on the map",
                    ),
                    Icon(Icons.arrow_right_alt_sharp)
                  ],
                )
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Text(
          //     "View on the map \u2192",
          //     style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey900),
          //   ),
          // )
        ],
      ),
    );
  }
}