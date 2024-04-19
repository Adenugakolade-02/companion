import 'package:caution_companion/pages/report/report_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final ReportViewModel model = ReportViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text("Emergency Report", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),)),
              const SizedBox(height: 32,),

              Text("Incident information", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),

              const SizedBox(height: 16,),

              Text("Incident Type", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
              const SizedBox(height: 4,),
              kDropDownFormField<dynamic>(items: List.from(model.reports).map((e) => DropdownMenuItem(child: Text(e))).toList(), validator: null),

              const SizedBox(height: 24,),

              Text("Location", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
              const SizedBox(height: 4,),
              kFormField(hintText: "", controller: TextEditingController(), suffixIcon: Icon(Icons.my_location_sharp, color: warning400,),),

              Text("Date of Incident", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
              const SizedBox(height: 4,),
              kFormField(hintText: "", controller: TextEditingController(), suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.keyboard_arrow_down_rounded)),),

              Text("Incident Description", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
              const SizedBox(height: 4,),
              kFormField(hintText: "", controller: TextEditingController(), maxLines: 5,),

              const Spacer(),

              ElevatedButton(onPressed: (){}, child: const Text("Send Report"))
            ],
          ),
        )
      ),
    );
  }
}