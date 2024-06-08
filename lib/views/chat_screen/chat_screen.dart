import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/chat_controller.dart';
import 'package:emart_app/services/services.dart';
import 'package:emart_app/views/chat_screen/sender_bubble.dart';
import 'package:emart_app/widgets/loading_indicator.dart';
class ChatScreen extends StatelessWidget {
   ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(ChatsController());
    print("Chat doc Id ${controller.chatDocId.toString()}");
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body:
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             children: [
               Obx(()
                 =>controller.isLoading.value?
                     Center(child: loadingIndicator(),):
                     Expanded(
                   child: StreamBuilder(
                    stream: FirestoreServices.getChatMsg(controller.chatDocId.toString()),
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
    if(!snapshot.hasData){
    return Center(
    child: loadingIndicator(),
    );
    }
    else if(snapshot.data!.docs.isEmpty){
      print(" 2 Chat doc Id ${controller.chatDocId.toString()}");
    return Center(
    child: "Send a Message".text.color(darkFontGrey).make(),

    );
    }
    else {
      print("3 Chat doc Id ${controller.chatDocId.toString()}");
      return
                    ListView(controller: _scrollController,
                          children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                            var data=snapshot.data!.docs[index];
                            return Align(alignment: data['uid']==currentUser!.uid?Alignment.centerRight:Alignment.centerLeft ,
                                child: senderBubble(data));
                          }).toList()
                        );  }   }  ),
                 ),
               ),

                Row(children: [
                  Expanded(child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: textfieldGrey
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: textfieldGrey
                            )),
                        hintText: "Type a message.."

                    ),
                  )),
                  IconButton(onPressed: () {
                    controller.sendMsg(controller.msgController.text);

                    controller.msgController.clear();
                    _scrollToBottom();

                  }, icon: const Icon(Icons.send, color: redColor,))
                ],

                ).box.height(80).padding(const EdgeInsets.all(12)).margin(
                    EdgeInsets.only(bottom: 8)).make(),



             ],
           ),
         ),

    );

  }
  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

}
