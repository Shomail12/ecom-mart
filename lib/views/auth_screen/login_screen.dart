import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/authController.dart';
import 'package:emart_app/views/auth_screen/signup.dart';
import 'package:emart_app/views/home_screen/home_screen.dart';
import 'package:emart_app/widgets/appLogo_widget.dart';
import 'package:emart_app/widgets/bg_widget.dart';
import 'package:emart_app/widgets/custom_textField.dart';
import 'package:emart_app/widgets/our_button.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controlle=Get.put(AuthController());

    return bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight*0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Log in to $appname".text.fontFamily(bold).size(18).white.make(),
          10.heightBox,
          Obx(()=>
             Column(
              children: [
customTextField(title:email,hint:emailHint,isPass: false,controller: controlle.emailController),
                customTextField(title:password,hint:passwordHint,isPass: true,controller: controlle.passwordController),

                Align(alignment: Alignment.centerRight,
                    child: TextButton(onPressed:(){},child: forgetPassword.text.make())),
                controlle.isloading.value?const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red),
                ):
                OurButton(color: redColor,textColor: whiteColor,title: login,onPres: ()async{
                  print("loggin");
                  controlle.isloading(true);
                  await controlle.loginMethod(context: context).then((value){
                    print("login $value");
                    VxToast.show(context, msg: loginSuccessfully);
                    Get.offAll(()=>const HomeScreen());
                      if(value !=null){
                       // print("login");
                        VxToast.show(context, msg: loginSuccessfully);
                        Get.offAll(()=>const HomeScreen());
                      }
                      else{
                        controlle.isloading(false);
                        print("not login");
                      }
                  });


                } ).box.width(context.screenWidth).make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                OurButton(color: lightgolden,textColor: redColor,title: signup,onPres: (){Get.to(()=>const SignUpScreen());} ).box.width(context.screenWidth).make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                10.heightBox,
                Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index)=>Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                  radius: 25,
                  backgroundColor: lightGrey,
                  child: Image.asset(socialIconList[index],width:30
                            ),
                ),
                    ),))

              ],
            ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth-70).shadowSm.make(),
          )

        ],),
      ),
    ));
  }
}
