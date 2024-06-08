import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_Controller.dart';
import 'package:emart_app/views/account/account.dart';
import 'package:emart_app/widgets/bg_widget.dart';
import 'package:emart_app/widgets/custom_textField.dart';
import 'package:emart_app/widgets/our_button.dart';
class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // var controller=Get.find<ProfileController>();
    final ProfileController controller = Get.find<ProfileController>();


    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar( leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(()=> Account()); // Navigate back using GetX
          },
        ),),
        body: Obx(()=>Column(
            mainAxisSize: MainAxisSize.min,
            children: [
           data['imageUrl']==''&& controller.profileImgPath.isEmpty ?
           Image.asset(imgProfile2 ,width: 100,fit:BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make():
           data['imageUrl']!=''&& controller.profileImgPath.isEmpty ?
           Image.network(data['imageUrl'] ,width: 100,fit:BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make():
              Image.file(File(controller.profileImgPath.value),width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              OurButton(
                color: redColor,onPres: (){
                  controller.changeImage(context);
              },textColor: whiteColor,title: "Change",),
                const Divider(),
              customTextField(title:name,hint:nameHint,isPass: false,controller: controller.nameController),
              10.heightBox,
              customTextField(title:oldPassword,hint:nameHint,isPass: true,controller: controller.oldpassController),
              10.heightBox,
              customTextField(title:newPassword,hint:nameHint,isPass: true,controller: controller.newpassController),

              20.heightBox,
             controller.isLoading.value?
             CircularProgressIndicator(
               valueColor: AlwaysStoppedAnimation(redColor),
             ): SizedBox(
                width: context.screenWidth-60,
                child: OurButton(
                  color: redColor,onPres: ()async{
                   controller.isLoading(true);
//if image is not selected then
                  if(controller.profileImgPath.value.isNotEmpty){
                    await controller.uploadProfileImage();
                  }
                  else{
                    controller.profileImageLink=data['imageUrl'];
                  }
// if old password matches database
                  if(data['password']==controller.oldpassController.text){
                    await controller.changeAuthPaswword(email: data['email'],
                    passwotd: controller.oldpassController.text,
                      newpassword: controller.newpassController.text
                    );
                   await controller.updateProfile(
                     imgUrl: controller.profileImageLink,
                     name: controller.nameController.text,
                     password: controller.newpassController.text
                   );
                    VxToast.show(context, msg: "Updated");}
                  else{
                    controller.isLoading(false);
                    VxToast.show(context, msg: "Wrong Old Password");
                  }

                },textColor: whiteColor,title: "Save",),
              ),



            ],
          ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top:50,left: 12,right: 12)).rounded.make(),
        ),
      )
    );
  }
}
