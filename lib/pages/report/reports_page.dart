import 'package:caution_companion/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Reports", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),)),
                const SizedBox(height: 24,),
          
                ...List.generate(7, (index) => _reportWidget())
              ],
            ),
          ),
          )
        ),

      floatingActionButton: FloatingActionButton(onPressed: (){},backgroundColor: error400, foregroundColor: Colors.white, child: const Icon(Icons.add)),
    );
  }


  Widget _reportWidget(){
    return Container(
      height: 109,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: grey400)
      ),
      child: Row(
        children: [
          SvgPicture.asset("assets/images/bell.svg"),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("NEW REPORT", style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey500),),
              const SizedBox(height: 2,),
              Text("Theft", style: TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
              const Spacer(),
              Text("3 hours ago ", style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w500, color: warning400),)
            ],
          ),
          const Spacer(),
          TextButton(onPressed: (){}, child: const Text("View on the map"))
        ],
      ),
    );
  }

}