import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/cart/payment_method.dart';
import 'package:emart_app/widgets/custom_textField.dart';
import 'package:emart_app/widgets/our_button.dart';
class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:  "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar:  SizedBox(height: 60,
          child:    OurButton(
              color: redColor,
              textColor: whiteColor,title: "Continue",onPres: (){
            Get.to(()=>PaymentMethod());
/*if(controller.addressController.text.length>10){
  Get.to(()=>ShippingDetails());
}else{
  VxToast.show(context, msg: "Please the form");
}*/

          })),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          customTextField(title:"Address",hint:"Address",isPass: false,controller: controller.addressController),
          customTextField(title:"City",hint:"City",isPass: false,controller: controller.cityController),
          customTextField(title:"State",hint:"State",isPass: false,controller: controller.stateController),
          customTextField(title:"Postal Code",hint:"Postal Code",isPass: false,controller: controller.postalController),
          customTextField(title:"Phone",hint:"Phone",isPass: false,controller: controller.phoneController),
        ],),
      ),
    );
  }
}
