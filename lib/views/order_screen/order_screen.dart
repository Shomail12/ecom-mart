import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/services.dart';
import 'package:emart_app/views/order_screen/order_details.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: whiteColor,
        appBar:AppBar(
          automaticallyImplyLeading:true,
          title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getAllOrders(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: loadingIndicator(),
                );
              }
              else if(snapshot.data!.docs.isEmpty){
                return Center(
                  child: "No Orders yet".text.color(darkFontGrey).make(),
                );
              }
              else{
                var data= snapshot.data!.docs;

                return
                  ListView.builder(itemCount: data.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    leading: "${index+1}".text.color(darkFontGrey).xl.fontFamily(bold).make(),
                    title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                      subtitle:data[index]['total_amount'].toString().numCurrency.text.fontFamily(semibold).make(),
                    trailing: IconButton(
                      onPressed: (){
                        Get.to(()=>OrderDetails(data:data[index]));
                      },
                        icon:const Icon(Icons.arrow_forward_ios_outlined)

                    ),
                  );
                },
                );
              }}
        )
    );
  }
}
