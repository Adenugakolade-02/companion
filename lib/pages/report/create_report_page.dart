import 'package:caution_companion/data/models/incident_model.dart';
import 'package:caution_companion/data/models/report_model.dart';
import 'package:caution_companion/pages/map/map_dialog.dart';
import 'package:caution_companion/pages/report/report_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/utils/validators.dart';
import 'package:caution_companion/utils/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  
  final ReportViewModel model = ReportViewModel();
  
  late TextEditingController reportDescription;
  late TextEditingController reportLocation;

  final formKey = GlobalKey<FormState>();

  IncidentType incidentType = IncidentType.accident;
  IncidentModel? incidentLocation;

  @override
  void initState() {
    reportDescription = TextEditingController();
    reportLocation = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    reportDescription.dispose();
    reportLocation.dispose();
    super.dispose();
  }

  void selectIncident(IncidentType? type){
    incidentType = type??IncidentType.accident;
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(onPressed: ()=>AppRoute.pop(), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black,),),
          title: Text("Emergency Report", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Form(
                key: formKey,
                child: ListView(
                      padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10
                  ),
                  children: [
                    // Center(child: Text("Emergency Report", style: TextStyle(fontSize: 18, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),)),
                    const SizedBox(height: 32,),
              
                    Text("Incident information", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w600, color: grey900),),
              
                    const SizedBox(height: 24,),
              
                    Text("Incident Type", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
                    const SizedBox(height: 4,),
                    kDropDownFormField<IncidentType>(items: IncidentType.values.map((e) => DropdownMenuItem(value: e,child: Text(e.value),)).toList(), validator: null, value: incidentType, callBack: selectIncident,),
              
                    const SizedBox(height: 24,),
              
                    Text("Location", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
                    const SizedBox(height: 4,),
              
                    kFormField(
                    hintText: "", 
                    controller: reportLocation,
                    readOnly: true, 
                    suffixIcon: GestureDetector(
                      onTap: ()async{
                        incidentLocation = await showDialog<IncidentModel>(
                        context: context, 
                        builder: (_)=>const MapDialog()
                        );
                        reportLocation.text = incidentLocation?.locationAddress??"";
                        },
                      child: Icon(Icons.my_location_sharp, color: warning400,)),
                      validator: genericValidator,
                    ),
                    const SizedBox(height: 24,),
                    Text("Incident Description", style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey900),),
                    const SizedBox(height: 4,),
                    kFormField(hintText: "", controller: reportDescription, maxLines: 5,),
              
                    const SizedBox(height: 40,),
              
                    ElevatedButton(onPressed: (){
                      if(formKey.currentState!.validate() && incidentLocation!=null){
                        model.createReport(incidentType: incidentType, location: incidentLocation!.location!, description: reportDescription.text);
                      }
                    }, child: const Text("Send Report"))
                  ],
                ),
              )
            ),
            Consumer<ReportViewModel>(
                builder: (_,model,__){
                  return model.state == ReportStates.loading ? Container(
                    height: size.height,
                    width: size.width,
                    color: Colors.black54, child: const Center(child: CircularProgressIndicator.adaptive()),) : Container();
                }
              )
          ],
        ),
      ),
    );
  }
}