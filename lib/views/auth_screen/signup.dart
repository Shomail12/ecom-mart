import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/authController.dart';
import 'package:emart_app/views/home_screen/home_screen.dart';
import 'package:emart_app/widgets/appLogo_widget.dart';
import 'package:emart_app/widgets/bg_widget.dart';
import 'package:emart_app/widgets/custom_textField.dart';
import 'package:emart_app/widgets/our_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck=false;
  var controller=Get.put(AuthController());
   var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var reTypePasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Obx(()=>Column(children: [
            (context.screenHeight*0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            " Join the $appname".text.fontFamily(bold).size(18).white.make(),
            10.heightBox,
            Column(
              children: [
                customTextField(title:name,hint:nameHint,controller: nameController,isPass: false),

                customTextField(title:email,hint:emailHint,controller: emailController,isPass: false),
                customTextField(title:password,hint:passwordHint,controller: passwordController,isPass: true),
                customTextField(title:retypePassword,hint:passwordHint,controller: reTypePasswordController,isPass: true),
                10.heightBox,
Row(children: [
  Checkbox(
  value: isCheck,
  activeColor: redColor,
  checkColor: whiteColor,
  onChanged: (newValue){
    setState((){
      isCheck=newValue;
    });

  }),
Expanded(
  child:   RichText(

    text: const TextSpan(children:[ TextSpan(text:"I agree to the ",style: TextStyle(fontFamily: regular,color: fontGrey)),

    TextSpan(text:"Term and Condition ",style: TextStyle(fontFamily: regular,color: redColor)),

      TextSpan(text:"& ",style: TextStyle(fontFamily: regular,color: fontGrey)),

      TextSpan(text:"Privacy Policy",style: TextStyle(fontFamily: regular,color: redColor)),





    ]),

  ),
),
]),
                10.heightBox,
                controller.isloading.value?const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ):
                OurButton(color:isCheck==true? redColor:lightGrey,textColor: whiteColor,title: signup,onPres: ()async{
                  if(isCheck!=false){
                    print("name $nameController.text");
                    print("email $emailController.text");
                    print("password $passwordController.text");
                    try{
                      await controller.signupMethod(context: context,email: emailController.text,password: passwordController.text
                      ).then((value) =>{
                         controller.storeUserData(
                          email:emailController.text,
                        password:passwordController.text,
                        name:nameController.text,)
                      }).then((value)=>{
                      controller.isloading(true),
                      VxToast.show(context, msg: loginSuccessfully),
                        //Get.offAll(HomeScreen())
                  });
                    }catch(e){
                      controller.isloading(false);
                      auth.signOut();
                      VxToast.show(context, msg: e.toString());
                    }
                  }
                  Get.to(()=>const HomeScreen());} ).box.width(context.screenWidth).make(),
                10.heightBox,

                RichText(
                  text: const TextSpan(children:[ TextSpan(text:alreadyHaveAnAccount,style: TextStyle(fontFamily: bold,color: fontGrey)),
                     TextSpan(text:login,style: TextStyle(fontFamily: bold,color: redColor)),
                  ]),

                ).onTap(() {Get.back();}),



              ],
            ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth-70).shadowSm.make()

          ],),
        ),
      ),
    ));
  }
}
