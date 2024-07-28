import 'package:caution_companion/data/models/user_model.dart';
import 'package:caution_companion/locator.dart';
import 'package:caution_companion/pages/authentication/auth_view_model.dart';
import 'package:caution_companion/utils/app_colors.dart';
import 'package:caution_companion/utils/app_routes.dart';
import 'package:caution_companion/utils/validators.dart';
import 'package:caution_companion/utils/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthViewModel model = serviceLocator<AuthViewModel>();
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController fName;
  late TextEditingController lName;
  late TextEditingController uName;
  late TextEditingController phone;
  late TextEditingController location;

  late String imageUrl;

  @override
  void initState() {
    fName = TextEditingController(text: model.user?.firstName ??'');
    lName = TextEditingController(text: model.user?.lastName ??'');
    uName = TextEditingController(text: model.user?.userName ??'');
    phone = TextEditingController(text: model.user?.phone ??'');
    location = TextEditingController(text: model.user?.location ?? '');
    imageUrl = model.user?.avatar ?? '';
    super.initState();
  }

  @override
  void dispose() {
    fName.dispose();
    lName.dispose();
    uName.dispose();
    phone.dispose();
    location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: model,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()=>AppRoute.pop(), 
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,)
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
                Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  children: [
                    Center(
                      child: SizedBox(
                        height: 146,
                        width: 146,
                        child: Stack(
                          children: [
                            NetworkImageWidget(
                              url: imageUrl, 
                              name: model.user?.firstName ?? "CC"
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: ()async{
                                    final file = await model.pickSingleImageAndCrop(isGallery: true);
                                    final url = await model.uploadProfilePicture(file);
                                    if(url==null){

                                    }
                                    else{
                                      imageUrl = url;
                                      setState(() {
                                        
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: warning400
                                    ),
                                    child: const Icon(Icons.camera_alt, size: 22, color: Colors.white,),
                                  ),
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40,),
                    EditFormField(title: 'First Name', controller: fName, validator: genericValidator,),
                    EditFormField(title: 'Last Name', controller: lName, validator: genericValidator),
                    EditFormField(title: 'UserName', controller: uName, validator: genericValidator),
                    EditFormField(title: 'Phone', controller: phone, validator: genericValidator),
                    EditFormField(title: 'Location', controller: location, validator: genericValidator),
              
                    const SizedBox(height: 10,),
              
                    ElevatedButton(onPressed: () async{
                      if(_formKey.currentState?.validate()??false){
                      final upadated =  await model.updateProfile(email: model.user!.email, firstName: fName.text, lastName: lName.text, userName: uName.text, location: location.text, phone: phone.text, avatar: imageUrl);
                      if(upadated){
                        AppRoute.pop();
                        model.getUser();
                      }else{
                        
                      }
                    }
                    }, child: const Text("Save Information"))
                  ],
                ),
              ),
              Consumer<AuthViewModel>(
                  builder: (_,model,__){
                    return model.isLoading ? Container(
                      height: size.height,
                      width: size.width,
                      color: Colors.black54, child: const Center(child: CircularProgressIndicator.adaptive()),) : Container();
                  }
                )
            ],
          )
        ),
      ),
    );
  }
}


class EditFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const EditFormField({super.key, required this.title, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w500, color: grey500),),
        const SizedBox(height: 4,),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: grey300
              )
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: grey300
              )
            )
          ),
        ),
        const SizedBox(height: 24,)
      ],
    );
  }
}