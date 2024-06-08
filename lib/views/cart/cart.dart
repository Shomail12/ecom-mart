
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/cart/shipping_screen.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
import 'package:emart_app/widgets/our_button.dart';

import '../../services/services.dart';
class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: context.screenWidth-50,
        child: OurButton(
            color:redColor,
            onPres:(){
Get.to(()=>ShippingDetails());
            },
            textColor: whiteColor,
            title: "Proceed to shipping"
        ),
      ),
     backgroundColor: whiteColor,
        appBar:AppBar(
    automaticallyImplyLeading:false,
          title: "Shopping cart".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
    body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
    if(!snapshot.hasData){
    return Center(
    child: loadingIndicator(),
    );
    }
    else if(snapshot.data!.docs.isEmpty){
    return Center(
    child: "No Product Found".text.color(darkFontGrey).make(),
    );
    }
    else{
    var data= snapshot.data!.docs;
    controller.calculate(data);
    controller.productSnapshot=data;
    print(controller.productSnapshot);
    return Padding(
padding:const EdgeInsets.all(8.0),
child: Padding(
padding:const EdgeInsets.all(8.0),
  child: Column(children: [Expanded(child: ListView.builder(
    itemCount: data.length,
    itemBuilder:(BuildContext context,int index){
      return ListTile(
        leading: Image.network("${data[index]['image']}",width: 80,fit: BoxFit.cover,),
        title: "${data[index]['title']} (x${data[index]['quantity']})"
            .text.fontFamily(semibold).size(16).make(),
        subtitle: "${data[index]['totalprice']}".numCurrency.text.fontFamily(semibold).color(redColor).size(16).make(),
      trailing: const Icon(Icons.delete,color: redColor,).onTap(() { FirestoreServices.deleteDocument(data[index].id); }),
      );
    } ,
  )),
Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: ["Total price".text.fontFamily(semibold).color(darkFontGrey).make(),
Obx(()=>"${controller.totalPrice.value}".numCurrency.text.fontFamily(semibold).color(darkFontGrey).make())],
).box.padding(EdgeInsets.all(12)).color(lightgolden).width(context.screenWidth-60).roundedSM.make(),

],),
),
);
    }}
    )
    );
  }
}
/*
Padding(
padding:const EdgeInsets.all(8.0),
child: Padding(
padding:const EdgeInsets.all(8.0),
child: Column(children: [Expanded(child: Container(color: Colors.red,)),
Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: ["Total price".text.fontFamily(semibold).color(darkFontGrey).make(),
"40".numCurrency.text.fontFamily(semibold).color(darkFontGrey).make()],
).box.padding(EdgeInsets.all(12)).color(lightgolden).width(context.screenWidth-60).roundedSM.make(),
SizedBox(
width: context.screenWidth-60,
child: OurButton(
color:redColor,
onPres:(){},
textColor: whiteColor,
title: "Proceed to shipping"
),
)
],),
),
),*/
