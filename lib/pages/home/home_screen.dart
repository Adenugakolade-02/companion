import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/report/report_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/widgets/home/home_emergency_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final model = serviceLocator<ReportViewModel>();
  @override
  void initState() {
    model.fetchReports();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
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
    
                  ...[Container(), Container()],
                  // const HomeEmergencyWidget(),
                  // const HomeEmergencyWidget(),
                  // const HomeEmergencyWidget(),
    
                  Consumer<ReportViewModel>(
                    builder: (_,model,__) {
                      return switch(model.state){
                        ReportStates.loading=>const Center(child: CircularProgressIndicator.adaptive(),),
                        ReportStates.fail => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Unable to fecth reports, try again"),
                            ElevatedButton(onPressed: ()=>model.fetchReports(), child: const Text("Try again"))
                          ],),
                        _ => Column(
                          children: [
                            if(model.reportList.isEmpty)
                              const Text("No Report available, create new reports"),
                            ...model.reportList.map((e) => HomeEmergencyWidget(reportModel: e)).toList()
                          ],
                        )
                      };
                    }
                  ),
            
                  const SizedBox(height: 24,),
            
                  Text("Create Emergency Reports", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
                  const SizedBox(height: 8,),
                  Text("Have you witnessed a crime or in a scene of an emergency? Spread awareness by creating an emergency report now", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400, color: grey500),),
                  const SizedBox(height: 24,),
                  ElevatedButton(onPressed: ()=>AppRoute.go(AppRoute.createReportPage), child: const Text("Create Emergency Report"))
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}