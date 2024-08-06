import 'package:caution_companion/data/models/report_model.dart';
import 'package:caution_companion/helpers/datetime_difference.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/map/map_view_model.dart';
import 'package:caution_companion/pages/report/report_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  final model = serviceLocator<ReportViewModel>();
  final mapModel = serviceLocator<MapViewModel>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("Reports", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),)),
                  const SizedBox(height: 24,),
            
                  ...model.reportList.map((e) => _reportWidget(e)).toList()
                ],
              ),
            ),
            )
          ),
    
        floatingActionButton: FloatingActionButton(onPressed: ()=>AppRoute.go(AppRoute.createReportPage),backgroundColor: error400, foregroundColor: Colors.white, child: const Icon(Icons.add)),
      ),
    );
  }


  Widget _reportWidget(ReportModel reportModel){
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/images/bell.svg"),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("NEW REPORT", style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey500),),
              const SizedBox(height: 2,),
              Text(reportModel.incidentType.name, style: TextStyle(fontSize: 16, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
              const Spacer(),
              Text(formatDateTimeDifference(reportModel.updatedAt), style: TextStyle(fontSize: 12, fontFamily: "Inter", fontWeight: FontWeight.w500, color: warning400),)
            ],
          ),
          const Spacer(),
          TextButton(onPressed: (){
            mapModel.setSelectedIncident(reportModel);
            AppRoute.go(AppRoute.homePage, arguments: 1);}, child: const Text("View on the map"))
        ],
      ),
    );
  }

}