import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/services.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
        appBar:AppBar(
          automaticallyImplyLeading:true,
          title: "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getAllMsgs(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: loadingIndicator(),
                );
              }
              else if(snapshot.data!.docs.isEmpty){
                return Center(
                  child: "No Messages yet".text.color(darkFontGrey).make(),
                );
              }
              else{
                var data= snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot=data;
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
