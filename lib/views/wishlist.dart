import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/services.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: whiteColor,
        appBar:AppBar(
          automaticallyImplyLeading:true,
          title: "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getWishlist(),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: loadingIndicator(),
                );
              }
              else if(snapshot.data!.docs.isEmpty){
                return Center(
                  child: "No Wishlist yet".text.color(darkFontGrey).make(),
                );
              }
              else{
                var data= snapshot.data!.docs;

                  return Column(
                    children: [
                      Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context,int index){
                          return  ListTile(
                          leading: Image.network("${data[index]['p_images'][0]}",
                            width: 80,
                            fit: BoxFit.cover,),
                          title: "${data[index]['p_name']} (x${data[index]['p_quantity']})"
                              .text.fontFamily(semibold).size(16).make(),
                          subtitle: "${data[index]['p_price']}".numCurrency.text.fontFamily(semibold).color(redColor).size(16).make(),
    trailing: const Icon(Icons.favorite,color: redColor,).onTap(() async{
      await firestore.collection(productsCollection).doc(data[index].id).set({
        'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
      },SetOptions(merge: true));
    }),
    );
    }),
                ),
                    ],
                  );

                };
              }
        )
    );
  }
}
