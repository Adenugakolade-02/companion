import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/widgets/home/home_emergency_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(),
                    Text("Hi Kalu, Welcome back", style: TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
                    const Spacer(),
                    Text("Ile-Ife", style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),)
                  ],
                ),
                const SizedBox(height: 24,),
                Row(
                  children: [
                    Text("New Emergency Reports Today", style: TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
                    const Spacer(),
                    TextButton(onPressed: (){}, child: const Text("See All"))
                  ],
                ),
                const HomeEmergencyWidget(),
                const HomeEmergencyWidget(),
                const HomeEmergencyWidget(),
          
                const SizedBox(height: 24,),
          
                Text("Create Emergency Reports", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
                const SizedBox(height: 8,),
                Text("Have you witnessed a crime or in a scene of an emergency? Spread awareness by creating an emergency report now", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey500),),
                const SizedBox(height: 24,),
                ElevatedButton(onPressed: (){}, child: const Text("Create Emergency Report"))
              ],
            ),
          ),
        )
      ),
    );
  }
}