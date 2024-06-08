import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/views/home_screen/home_screen.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:emart_app/widgets/our_button.dart';
class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Obx(()
      => Scaffold(
        bottomNavigationBar: SizedBox(
          width: context.screenWidth-50,
          child:controller.placingOrder.value?Center(child: loadingIndicator(),): OurButton(
              color:redColor,
              onPres:()async{
                controller.placeMyorder(orderPaymentMethod: paymentMethods[controller.paymentIndex.value],
      totalAmount: controller.totalPrice.value);
await controller.clearCart();
VxToast.show(context, msg: "Order placed successfully");
Get.offAll(HomeScreen());
              },
              textColor: whiteColor,
              title: "Place my order"
          ),
        ),
          backgroundColor: whiteColor,
          appBar: AppBar(
          title:  "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Column(children:
       List.generate(paymentMethodImg.length, (index) {
         return Padding(
           padding: const EdgeInsets.only(bottom: 8.0),
           child: GestureDetector(onTap: (){
             controller.changePaymentIndex(index);
           },
             child: Container(
               clipBehavior: Clip.antiAlias,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
               border: Border.all(style: BorderStyle.solid,
               color: controller.paymentIndex.value==index?redColor:Colors.transparent,
               width: 5)
               ),
               child: Stack(
                   alignment: Alignment.topRight,
                   children:[ Image.asset(
                     paymentMethodImg[index],
                     colorBlendMode:controller.paymentIndex.value==index? BlendMode.darken:BlendMode.color,
                     color: controller.paymentIndex.value==index?Colors.black.withOpacity(0.4):Colors.transparent,
                     width: double.infinity,height: 120,fit: BoxFit.cover,),
              controller.paymentIndex.value==index?
               Transform.scale(scale: 1.3,
                 child: Checkbox(
                   activeColor: Colors.green,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(50)
                     ),
                     value: true, onChanged: (value) {}),
               ):Container(),
                     Positioned(
                       bottom: 10,
                         right: 10,
                         child: paymentMethods[index].text.white.fontFamily(semibold).size(16).make())
               ])
             ),
           ),
         );
       })
      ),
      ),
    );
  }
}
