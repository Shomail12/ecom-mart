import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/services.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                print("No msg");
                return Center(
                  child: "No Messages yet".text.color(darkFontGrey).make(),
                );
              }
              else{
                var data= snapshot.data!.docs;
                print("Msg data ${data}");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context,int index){
                              return  Card(
                                child: ListTile(
                                  onTap: (){
                                    Get.to(()=> ChatScreen(),arguments:[data[index]['friend_name'],
                                    data[index]['toId']]);
                                  },
                                  leading: const CircleAvatar(backgroundColor: redColor,
                                  child: Icon(Icons.person,
                                  color: whiteColor,),
                                   ),
                                  title: "${data[index]['friend_name']}"
                                      .text.fontFamily(semibold).color(darkFontGrey).make(),
                                  subtitle: "${data[index]['last_msg']}".text.make(),

                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }}
        )
    );
  }
}
